## submission: gurbaaz singh nandra (190349)

module Context
  NONE, LIST, PARAGRAPH = 0,1,2
end

# actually we need to maintain a stack of contexts, and pop off
# on completion

class BasicOutputter
  def initialize filename
    @line=nil
    @para_beginning = true
    @list_beginning = true
    @bold_beginning = true
    @emphasis_beginning=true
    @filename=filename
    @context=Context::NONE
  end
  def bold
  end
  def emphasis
  end
  def list
  end
  def paragraph
  end
  def heading
  end
  def reset_context
  end
  def process
  end
  def parse
  end
end


class HTMLOutputter < BasicOutputter
  def bold
  end

  def emphasis
  end

  def list
    printf "<li> %s </li>", @line[2..-1]
  end
  
  def heading
    level = 0
    i     = 0
    while @line[i]=='#'
      level = level+1
      i = i+1
    end
    printf "<h%d>%s</h%d>\n", level,@line[i..-2],level
  end

  def reset_context
    case @context
    when Context::LIST
      puts "</ul>"
    when Context::PARAGRAPH
      puts "</p>"
      @para_beginning = true 
    end
  end

  def process
    @line.each_char do |c|
      case c
      when '*'
        if @bold_beginning
          printf "<b>"
          @bold_beginning = false
        else
          printf "</b>"
        end
      when '/'
        if @emphasis_beginning
          printf "<em>"
          @emphasis_beginning = false
        else
          printf "</em>"
        end
      else
        putc c
      end
    end
  end
  
  def paragraph
    process 
  end

  def heading
    level = 0
    i     = 0
    while @line[i]=='#'
      level = level+1
      i = i+1
    end
    
    printf "<h%d>%s</h%d>\n", level,@line[i..-2],level
  end


  def parse
    File.readlines(@filename).each do |text_line|
      if text_line.strip.empty?
        reset_context
        @context = Context::NONE
        next
      end
      @line = text_line
      case @line[0]
      when '#'
        heading 
      when '+'
        if @list_beginning == true
          puts "<ul>"
          @list_beginning = false
        end
        list
        @context = Context::LIST
      else 
        if @para_beginning == true
          puts "<p>"
          @para_beginning = false
        end          
        paragraph
        @context = Context::PARAGRAPH
      end
    end
  end
end

class LaTeXOutputter < BasicOutputter
  def bold
  end

  def emphasis
  end

  def list
    printf "\\item "
    @line=@line[2..-1]
    process
  end
  
  def heading
    level = 0
    i     = 0
    while @line[i]=='#'
      level = level+1
      i = i+1
    end
    header = ""
    case level
    when 1
      header = "\\huge"
    when 2
      header = "\\LARGE"
    when 3
      header = "\\Large"
    when 4
      header = "\\large  "
    when 5
      header = "\\normalsize"
    else 
      header = "\\small"
    end
    printf "%s{%s}\\\\\n", header,@line.chomp[i..]
  end
  
  def reset_bold_em
    @bold_beginning=true
    @emphasis_beginning=true
  end
  
  def reset_context
    case @context
    when Context::LIST
      puts "\\end{itemize}"
      @list_beginning = true
    when Context::PARAGRAPH
      @para_beginning = true 
    end
    @context = Context::NONE
  end

  def process
    @line.each_char do |c|
      case c
      when '*'
        if @bold_beginning
          printf "\\textbf{"
          @bold_beginning = false
        else
          printf "}"
        end
      when '/'
        if @emphasis_beginning
          printf "\\textit{"
          @emphasis_beginning = false
        else
          printf "}"
        end
      else
        putc c
      end
    end
    reset_bold_em
  end
  
  def paragraph
    process 
  end

  def parse
    puts "\\documentclass{article}"
    puts "\\usepackage[utf8]{inputenc}"
    puts "\\begin{document}"

    File.readlines(@filename).each do |text_line|
      if text_line.strip.empty?
        reset_context
        next
      end
      @line = text_line
      case @line[0]
      when '#'
        heading 
      when '+'
        if @list_beginning == true
          reset_context
          puts "\\begin{itemize}"
          @list_beginning = false
        end
        list
        @context = Context::LIST
      else 
        if @context == Context::LIST
          puts @line
          next
        end
        if @para_beginning == true
          reset_context
          puts "\\\\"
          @para_beginning = false
        end          
        paragraph
        @context = Context::PARAGRAPH
      end
    end
    puts "\\end{document}"
  end
end

# o = HTMLOutputter.new "sample.md"
# o.parse

o = LaTeXOutputter.new "sample.md"
o.parse
