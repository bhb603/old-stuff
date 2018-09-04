# require 'player.rb'
# require 'rspec'
# 
# 
# describe Player do
# 
#   subject(:player) { Player.new("MONEY_MAKER69", 1000, game)}
#   let (:game) { double("game") }
#   let (:c1) { Card.new(14,:heart) }
#   let (:c2) { Card.new(13,:heart) }
#   let (:c3) { Card.new(12,:heart) }
#   let (:c4) { Card.new(11,:heart) }
#   let (:c5) { Card.new(10,:heart) }
# 
#   let (:c6) { Card.new(2,:diamond) }
#   let (:c6a) {Card.new(2,:club) }
#   let (:c7) { Card.new(2,:heart) }
#   let (:c7a) { Card.new(2,:spade) }
#   let (:c8) { Card.new(5,:diamond) }
#   let (:c9) { Card.new(5,:spade) }
#   let (:c10) { Card.new(5,:heart) }
# 
# 
# 
# 
#   it "receives cards" do
#   allow(game).to receive(:deal_cards).and_return([c1,c2,c3,c4,c5])
#   player.receive_cards(5)
#   expect(player.hand.count).to eq(5)
# 
#   end
# 
#   it "folds" do
# 
#     player.fold
#     expect(player.folded).to eq(true)
#   end
# 
#   it "updates stack appropriately when raising" do
#     allow(game).to receive(:add_to_pot).with(600)
# 
#     player.raise(600)
# 
#     expect(player.chipstack).to eq(400)
# 
#   end
# 
#   it "updates stack when calling" do
#     allow(game).to receive(:add_to_pot).with(200)
#     player.call(200)
#     expect(player.chipstack).to eq(800)
#   end
# 
#   it "pays ante" do
#     allow(game).to receive(:add_to_pot).with(20)
#     player.pay_ante(20)
#     expect(player.chipstack).to eq(980)
#   end
# 
#   it "redraws cards" do
#     allow(game).to receive(:deal_cards).with(3).and_return([c8,c9,c10])
#     player.discard_redraw([0,3,4])
#     expect(player.hand.include?(c8)).to eq(true)
#     expect(player.hand.include?(c10)).to eq(true)
# 
#   end
# 
#   it "win pot" do
#     player.win_pot(1)
#     expect(player.chipstack).to eq(1001)
#   end
# 
# 
# 
# 
# 
# end