require_relative 'card.rb'

class Deck
  SUITS = [:heart, :spade, :diamond, :club]

  attr_reader :cards
  
  def initialize
    @cards = generate_cards
    shuffle
  end

  def generate_cards
    deck = []

    SUITS.each do |suit|
      (2..14).each do |value|
        deck << Card.new(value, suit)
      end
    end

    deck
  end

  def shuffle
    cards.shuffle!
  end

  def deal(n)
    cards.pop(n)
  end

end