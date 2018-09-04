require "deck.rb"

describe Deck do
  subject(:deck) { Deck.new }

  it "has 52 cards" do
    expect(deck.cards.count).to eq(52)
  end
  
  it "has no duplicate cards" do
    expect(deck.cards.uniq {|card| [card.value, card.suit]}).to eq(deck.cards)
  end
  
  context "it can deal cards" do
    
    deck = Deck.new
    cards = deck.deal(2)
    
    it "removes cards from deck" do
      expect(deck.cards.count).to eq(50)
      cards.each do |card|
        expect(deck.cards.include?(card)).to eq(false)
      end
    end
  end
end