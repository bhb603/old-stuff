
class Player

  attr_accessor :folded
  attr_reader :name, :hand, :bankroll

  def initialize(name, bankroll)
    @name, @bankroll = name, bankroll
    @folded = false
    @hand = Hand.new(self, [])
  end
  
  def clear_hand
    @hand = Hand.new(self, [])
  end
  
  def pay_ante(amt)
    if bankroll >= amt
      subtract_from_bankroll(amt)
      return amt
    else
      folded = true
      return 0
    end
  end

  def take_cards(cards)
    @hand.add_cards(cards)
  end
  
  def take_pot(amt)
    add_to_bankroll(amt)
  end
  
  def discard
    puts "#{name}, which cards would you like to discard?"
    puts "(Enter coma separated indices)"
    input = gets.chomp
    hand.discard_cards(parse_input(input))
  end
  
  private

  def subtract_from_bankroll(amt)
    @bankroll -= amt 
  end
  
  def add_to_bankroll(amt)
    @bankroll += amt
  end
  
  def parse_input((input))
    indices = input.split(",").map { |i| i.to_i }
  end

end