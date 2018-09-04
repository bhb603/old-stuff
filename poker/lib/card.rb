# coding: utf-8 

require "colorize"

class Card
  
  SYMBOLS = {:spade => "♠", :heart => "♥", :diamond => "♦", :club => "♣"}
  NAMES = {11 => "J", 12 => "Q", 13 => "K", 14 => "A"}
  
  attr_reader :value, :suit

  def initialize(value, suit)
    @value, @suit = value, suit
  end

  def same_suit?(other_card)
    self.suit == other_card.suit
  end

  def same_value?(other_card)
    self.value == other_card.value
  end
  
  def to_s
    "[#{name}#{SYMBOLS[suit]}]".colorize(color) 
  end
  
  def color
    if suit == :heart || suit == :diamond
      :red
    else
      :black
    end
  end
  
  def name
    if value <= 10
      value
    else
      NAMES[value]
    end
  end
  
end
