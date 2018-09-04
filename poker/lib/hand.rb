require_relative 'card.rb'

class Hand
  attr_reader :cards, :player
  
  def initialize(player, cards)
    @player, @cards = player, cards    
    sort_cards   
  end
  
  def rank
    ranks = [straight_flush?, quads?, full_house?, flush?,
            straight?, trips?, two_pair?, pair?]
            
    counter = 8
    ranks.each do |rank|
      return counter if rank
      counter -= 1
    end 
    counter
  end
  
  def sort_cards
    @cards.sort! { |card1, card2| card1.value <=> card2.value }
  end
  
  def discard_cards(card_indices)
    card_indices.sort { |a,b| b <=> a }.each do |i|
      @cards.delete_at(i)
    end
  end
  
  def add_cards(cards)
    @cards += cards
    sort_cards
  end
  
  def to_s
    # " #{(0..4).to_a.join("    ")}\n#{cards.join(" ")}"
    cards.join(" ")
  end
  
  def straight_flush?
    straight? && flush?
  end
  
  def quads?
    card_values.each do |card_value|
      if card_values.count(card_value) == 4
        return true
      end
    end
    
    false
  end
  
  def full_house?
    trips? && pair?   
  end
  
  def flush?
    card_suits.uniq.count == 1
  end
  
  def straight?
    card_vals = card_values
    card_vals.each_index do |i|
      next if card_vals[i + 1].nil?
      return false unless card_vals[i + 1] == card_vals[i] + 1
    end 
    
    true
  end
    
  def trips?
    card_values.each do |card_value|
      if card_values.count(card_value) == 3
        return true
      end
    end
    
    false
  end
    
  def two_pair?
    pairs = 0
    card_values.each do |card_value|
      if card_values.count(card_value) == 2
        pairs += 1
      end
    end
    
    pairs == 4 ? true : false
    
  end
  
  def pair?
    card_values.each do |card_value|
      if card_values.count(card_value) == 2 && !two_pair?
        return true
      end
    end
    false
  end
  
  private
  
  def card_values
    cards.map {|card| card.value}
  end
  
  def card_suits
    cards.map {|card| card.suit}
  end

end
