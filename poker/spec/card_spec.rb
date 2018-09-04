require 'card.rb'

describe Card do
  
  subject(:card) { Card.new(5, :heart) }
  let(:card2) {Card.new(5, :spade)}
  let(:card3) {Card.new(9, :heart)}

  it "stores its value" do
    expect(card.value).to eq(5)
  end

  it "stores its suit" do
    expect(card.suit).to eq(:heart)
  end
  
  it "knows when another card has same value" do
    expect(card.same_value?(card2)).to eq(true)
  end
  
  it "knows when another card doesn't have same value" do
    expect(card.same_value?(card3)).to eq(false)
  end
  
  it "knows when another card has same suit" do
    expect(card.same_suit?(card3)).to eq(true)
  end
  
  it "knows when another card doesn't have same suit" do
    expect(card.same_suit?(card2)).to eq(false)
  end

end