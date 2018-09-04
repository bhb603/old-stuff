require_relative "player.rb"
require_relative "hand.rb"
require_relative "deck.rb"
require_relative "card.rb"

class Game

  attr_reader :players

  def initialize(players)
    @players = players
  end

  def play_game
    deal_counter = 0
    quit = false
    until quit
      dealer_pos = deal_counter % players.count
      puts "Dealer: #{dealer_pos}"

      unfold_players
      play_hand(dealer_pos)
      deal_counter += 1
      
      puts "Play again? (y/n)"
      input = gets.chomp
      input == "y" ? quit = false : quit = true
    end
  end
  
  def play_hand(dealer_pos)
    deck = Deck.new
    clear_hands
    ante = 100 #could be configurable later
    pot = ante_up(ante)    
    deal_cards(deck)
    display_hands #obv should be secret
    
    #make_bets -- UNFINISHED FUNCTIONALITY
    
    draw_cards(deck)
    display_hands
    
    #make_bets -- UNFINISHED FUNCTIONALITY
    
    winner = calculate_winner
    winner.take_pot(pot)
    puts "#{winner.name} has won! Pot value: $#{pot}"
    players.each {|player| puts "#{player.name} ($#{player.bankroll})"}
    
  end
  
  private
  
  def game_over?
    false
  end
  
  def clear_hands
    players.each do |player|
      player.clear_hand
    end
  end
  
  def deal_cards(deck)
    players.each do |player|
      player.take_cards(deck.cards.pop(5))
    end
  end

  def draw_cards(deck)
    players.each do |player|
      player.discard
    end
    
    players.each do |player|
      cards_needed = 5 - player.hand.cards.count
      player.take_cards(deck.cards.pop(cards_needed))
    end
      
  end
  
  def display_hands
    players.each do |player|
      puts "#{player.name} ($#{player.bankroll})"
      puts player.hand
      puts "--"
    end
  end
  
  def ante_up(ante)
    total = 0
    players.each do |player|
      total += player.pay_ante(ante)
    end
    total
  end
  
  def calculate_winner
    rankings = []
    
    players.each do |player|
      rankings << [player, player.hand.rank]
    end 
    
    rankings.sort! {|r1, r2| r2[1] <=> r1[1]}
    
    rankings[0][0]  
  end
  
  def unfold_players
    players.each do |player|
      player.folded = false
    end
  end
  
  # UNFINISHED
  def make_bets
    #variable = who raised?
    #variable - minimum pot to stay in game.
    #next if player.folded
  end

end

if __FILE__ == $PROGRAM_NAME
  
  players = []
  if ARGV.count > 0  
    ARGV.count.times do 
      players << Player.new(ARGV.shift, 1000)
    end
  else
    players = [Player.new("Tom", 1000),
              Player.new("Jerry", 1000)]
  end
  
  g = Game.new(players)
  g.play_game
  
end