require 'io/console'

module FancyGets

  def gets_auto_suggest(words)
    string = ""
    position = 0
    sugg = ""
    loop do
      ch = STDIN.getch
      code = ch.ord
      case code
      when 3 # CTRL-C
        exit
      when 13 # ENTER
        break
      when 27  # ESC -- which means lots of special stuff
        case ch = STDIN.getch.ord
        when 79  # ESC -- which means lots of special stuff
          puts "ESC 79"
          case ch = STDIN.getch.ord
          when 80 #F1
            puts "F1"
          when 81 #F2
          when 82 #F3
          when 83 #F4
          when 84 #F5
          when 85 #F6
          when 86 #F7
          when 87 #F8
          when 88 #F9
          when 89 #F10
          when 90 #F11
          when 91 #F12
          when 92 #F13
          end
        when 91 # Special stuff
          case ch = STDIN.getch.ord
          when 68 # Arrow left
            if position > 0
              print "\b" # 27.chr + 91.chr + 68.chr
              position -= 1
            end
          when 67 # Arrow right
            if position < string.length
              print 27.chr + 91.chr + 67.chr
              position += 1
            end
          # 66 - down
          # 65 - up
          # else
          #   puts "ESC #{ch}"
          end
        else
          # Sometimes more, like for function keys
          puts "code #{ch} #{STDIN.getch.ord} #{STDIN.getch.ord} #{STDIN.getch.ord} #{STDIN.getch.ord}"
        end
      when 127 # Backspace
        if position > 0
          print "\b#{string[position..-1]} #{"\b" * (string.length - position + 1)}"
          string = string[0...position - 1] + string[position..-1]
          position -= 1
        end
      when 126 # Delete (forwards)
        if position < string.length
          print "#{string[position + 1..-1]} #{"\b" * (string.length - position)}"
          string = string[0...position] + string[position + 1..-1]
        end
      else # Insert character
        # print "#{ch}#{string[position..-1]}#{"\b" * (string.length - position)}"
        # Find first word that case-insensitive matches what they've typed
        string = string[0...position] + ch + string[position..-1]
        prev_sugg = sugg
        sugg = words.select { |word| word.downcase.start_with? string.downcase }.first || ""
        extra_spaces = prev_sugg.length - sugg.length
        extra_spaces = 0 if extra_spaces < 0
        position += 1
        print "#{ch}#{string[position..-1]} - #{sugg}#{" " * extra_spaces}#{"\b" * ((sugg.length + 3 + extra_spaces) + string.length - position)}"
      end
    end
    # puts "\n#{string}, position #{position}"
    sugg.empty? ? string : sugg
  end

end
