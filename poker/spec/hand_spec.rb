require "hand.rb"

describe Hand do
  context do        
    let(:h2) { Card.new(2, :heart) }
    let(:h3) { Card.new(3, :heart) }
    let(:h4) { Card.new(4, :heart) }
    let(:h5) { Card.new(5, :heart) }
    let(:h6) { Card.new(6, :heart) }
    let(:c14) { Card.new(14, :club) }
    let(:s10) { Card.new(10, :spade) }
    let(:s2) { Card.new(2, :spade) }
    let(:d4) { Card.new(4, :diamond)}
    let(:c2) { Card.new(2, :club)}
    let(:d2) { Card.new(2, :diamond)}
    let(:h9) { Card.new(9, :heart)}
    
    subject(:hand) { Hand.new("P1", [h2, h4, h3, h5, h6]) }

    it "sorts its cards by value" do
      expect(hand.cards).to eq([h2, h3, h4, h5, h6])
    end
  
    it "discards cards by index" do      
      hand.discard_cards([1,4])
      expect(hand.cards.count).to eq(3)
      expect(hand.cards.include?(h2)).to eq(true)
      expect(hand.cards.include?(h6)).to eq(false)
    end
    
    it "adds cards" do
      expect(hand.cards.include?(c14)).to eq(false)
      hand.add_cards([c14, s10])
      expect(hand.cards.count).to eq(7)
      expect(hand.cards.include?(c14)).to eq(true)
    end
    
    it "detects straight flush" do
      hand1 = Hand.new("P1", [h2, h3, h4, h5, h6])
      hand2 = Hand.new("P1", [h2, d2, c2, d4, s2])
      
      expect(hand1.straight_flush?).to eq(true)
      expect(hand2.straight_flush?).to eq(false)
    end
    
    it "detects four of a kind" do
      hand1 = Hand.new("P1", [h2, d2, c2, d4, s2])
      hand2 = Hand.new("P1", [h2, h3, c2, c14, s2])
      
      expect(hand1.quads?).to eq(true)
      expect(hand2.quads?).to eq(false)
    end
    
    it "detects full house" do
      hand1 = Hand.new("P1", [h2, d2, h4, d4, s2])
      
      expect(hand1.full_house?).to eq(true)
    end
    
    it "detects a flush" do
      hand1 = Hand.new("P1", [h2, h3, h4, d4, s2])
      hand2 = Hand.new("P1", [h2, h3, h4, h5, h6])
      
      expect(hand1.flush?).to eq(false)
      expect(hand2.flush?).to eq(true)
    end
    
    it "detects a straight" do
      hand1 = Hand.new("P1", [h2, h3, h4, d4, s2])
      hand2 = Hand.new("P1", [h6, h3, d4, h5, h2])
      
      expect(hand1.straight?).to eq(false)
      expect(hand2.straight?).to eq(true)
    end
    
    it "detects tripples" do
      hand1 = Hand.new("P1", [h2, h3, h4, d4, s2])
      hand2 = Hand.new("P1", [h2, h3, c2, c14, s2])
      
      expect(hand1.trips?).to eq(false)
      expect(hand2.trips?).to eq(true)
    end
    
    it "detects two pair" do
      hand1 = Hand.new("P1", [h2, h3, h4, d4, s2])
      hand2 = Hand.new("P1", [h2, h3, h4, c14, s2])
      
      expect(hand1.two_pair?).to eq(true)
      expect(hand2.two_pair?).to eq(false)
    end
    
    it "detects a pair" do
      hand1 = Hand.new("P1", [h2, h3, h4, c14, s2])
      hand2 = Hand.new("P1", [h2, h3, h4, c14, s10])
      
      expect(hand1.pair?).to eq(true)
      expect(hand2.pair?).to eq(false)
    end
    
    it "calculates rank" do
      hands = [ Hand.new("P1", [h2, h3, h4, c14, s10]),
                Hand.new("P1", [h2, h3, h4, c14, s2]),
                Hand.new("P1", [h2, h3, h4, d4, s2]),
                Hand.new("P1", [h2, h3, c2, c14, s2]),
                Hand.new("P1", [h6, h3, d4, h5, h2]),
                Hand.new("P1", [h2, h3, h4, h5, h9]),
                Hand.new("P1", [h2, d2, h4, d4, s2]),
                Hand.new("P1", [h2, d2, c2, d4, s2]),
                Hand.new("P1", [h2, h3, h4, h5, h6])
              ]
                
      hands.each_with_index do |h, i|
        expect(h.rank).to eq(i)
      end      
    end
    
  end
  
end