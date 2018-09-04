class Helpers

  def self.complete_parentheses?(str)

    stack = []
    str.each_char do |c|
      case c
      when "("
        stack << c
      when ")"
        if stack[-1] == "("
          stack.pop
        else
          stack << c
        end
      end
      
    end

    return (stack.count == 0)

  end

end
