require 'gosu'

def dist(loc1, loc2)
  dist_x = (loc1[0]-loc2[0]) * (loc1[0]-loc2[0])
  dist_y = (loc1[1]-loc2[1]) * (loc1[1]-loc2[1])
  return Integer.sqrt(dist_x+dist_y)
end

module DIRECTION
  RIGHT,LEFT=0,180
end

#=====================================
# Common data for the game, and the
# update code
#======================================
class Game < Gosu::Window
  
  def initialize
    super 640, 480, borderless:true, fullscreen:true
    self.caption = "Plumbers to the rescue"
    @background = Gosu::Image.new("images/wall.png")
    @font = Gosu::Font.new(20)

    @plumber = ActiveCharacter.new("plumber",
                                   100,
                                   {name:"vorpal sword", hit:2, range:30},
                                   ["images/plumber2-1.png","images/plumber2-2.png"],
                                   [])
    @dragon  = WeaponCharacter.new("dragon",
                             200,
                             {name:"fireball", hit:20},
                             ["images/dragon2-1.png","images/dragon2-2.png"])
    @princess = Character.new("princess",
                              10000,
                              ["images/princess2.png"])
    @plumber.warp(40,40)
    @dragon.warp(200,100)
    @dragon.volte_face
    @princess.warp(300,100)

    @ruby = Gosu::Image.new("images/ruby.png")
    
    # @A = Room.new "A", [2,1,0,0]
    # @B = Room.new "B", [-1,-1,0,0]
    # @C = Room.new "C", [2,3,2,0]
    # @D = Room.new "D", [4,4,2,2]
    # @E = Room.new "E", [4,5,4,3]
    # @F = Room.new "F", [5,5,5,5]

    # @rooms   = [@A,@B,@C,@D,@E,@F]
    @end_game = false
  end


  def update
    if Gosu.button_down? Gosu::KB_Q
      self.close!
    end
    if Gosu.button_down? Gosu::KB_LEFT
      @plumber.update_more(-1,0) # turn right
      @plumber.update
    end
    if Gosu.button_down? Gosu::KB_RIGHT
      @plumber.update_more(1,0)
      @plumber.update      
    end  
    if Gosu.button_down? Gosu::KB_DOWN
      @plumber.update_more(1,-1) # should preserve the horiz direction
    end
    if Gosu.button_down? Gosu::KB_UP
      @plumber.update_more(1,1) # should preserve the horiz direction
    end
   
    
    @plumber.update
    @dragon.update
    @princess.update

    self.collision_detect
  end

  def collision_detect
    ploc = @plumber.get_loc
    dloc = @dragon.get_loc
    rloc = @princess.get_loc
    if Gosu::distance(ploc[0], ploc[1], dloc[0], dloc[1]) < @plumber.attack_range
      @plumber.attack(@dragon)
    elsif Gosu::distance(ploc[0], ploc[1], rloc[0], rloc[1]) < 30
      @end_game=true
    elsif Gosu::distance(ploc[0], ploc[1], 320, 200) < 30
      @plumber.add "ruby"
      @picked_ruby = true
    end
  end
  

  def draw
    if  @end_game == false
      @background.draw(0,0,0)
      @ruby.draw(320,240,0)
      if @picked_ruby == true
        @font.draw_text("You picked up a ruby!", 10, 240, 2, 1.0, 1.0, Gosu::Color::YELLOW)
        @picked_ruby = false
      end
      @plumber.draw
      @princess.draw
      @dragon.draw
    else
      if @plumber.has?("ruby") and @dragon.dead? 
        mangalam=<<-END
                I would have much preferred Smalltalk.

                But Ruby is fine. 

                And they lived happily ever after.
                END
        @font.draw_text(mangalam, 10, 100, 2, 1.0, 1.0, Gosu::Color::YELLOW)
      else
        @font.draw_text("Got something for me?", 10, 100, 2, 1.0, 1.0, Gosu::Color::YELLOW)
        @end_game = false
      end
    end
  end

end

#=======================================
# common class for all characters in the game
#======================================r
class Character 
  def initialize(name,health,img)
    @name=name
    @health=health
    @x=0
    @y=0
    @direction=1
    @image = Array.new(img.length)
    (img.length).times do |i|
      @image[i] = Gosu::Image.new(img[i])
    end
    @x=0
    @y=0
    @direction=1
    @velocity=0
  end
  def warp(x,y)
    @x,@y=x,y
  end
  def dead?
    return @health <= 0
  end
  def reduce_health_by(num)
    @health = [@health-num,0].max
  end
  def update
    @x = @x + (@direction*@velocity)
  end
  def update_more(horizontal_direction,vertical_direction)
    @velocity = 1
    @direction = horizontal_direction
    if vertical_direction == 1
    then @y = @y - 2 # jumps up
    elsif vertical_direction == -1 then @y = @y + 2 # jump down
    end
  end
  def volte_face
    @direction *= -1
  end
  def draw
    if @direction==1
      @image[0].draw(@x,@y,1,2,2)
    else # flipped image
      @image[1].draw(@x,@y,1,2,2)
    end unless self.dead?
  end
  def get_loc
    return @x,@y
  end
end 

class WeaponCharacter < Character
  def initialize(name,health,weapon,img)
    super name,health,img
    @weapon=weapon
  end
  def attack(target)
    target.reduce_health_by(@weapon[:hit])
  end
end

class ActiveCharacter < WeaponCharacter
  def initialize(name,health,weapon,img,items)
    super name,health,weapon,img
    @items = items
  end
  def add item
    @items.append item
  end
  def has? item
    return @items.include? item
  end
  def attack_range
    return @weapon[:range]
  end
end

#=============================
# The rooms are the levels in the game
# Each room has neighbors you can go to
# depending on the key pressed, and the location
# of the character
#
# all other combinations produce no change
#==================================
class Room
  def initialize (name, neighbors)
    @name = name
    @neighbors = neighbours # has up to 8 neighbors, including itself
  end
end



Game.new.show
