# gems 
require "colorize"

# files
require_relative "./chess/board.rb"
require_relative "./chess/piece.rb"
require_relative "./chess/sliding_piece.rb"
require_relative "./chess/stepping_piece.rb"
require_relative "./chess/game_pieces.rb"
require_relative "./chess/human_player.rb"
require_relative "./chess/errors.rb"

class Chess
  attr_reader :board, :players

  def initialize(name1 = "Player 1", name2 = "Player 2")
    @board = Board.new
    @players = {:white => HumanPlayer.new(name1, :white),
                :black => HumanPlayer.new(name2, :black)}
  end

  def play
    turn = :white
    until @board.checkmate?(turn)
      @board.render
      puts "You are in check" if @board.in_check?(turn)
      begin
        start, stop = @players[turn].play_turn

        if @board[start].color == turn
          @board.move(start, stop)
        else
          raise WrongPieceError
        end
      rescue WrongPieceError
        puts "Not your piece!"
        retry
      rescue NilPieceError => e
        puts "Invalid start position"
        retry
      rescue InvalidMoveError => f
        puts "Invalid stop position"
        retry
      end

      turn == :white ? turn = :black : turn = :white
    end

    end_condition(turn)
  end

  private
  def end_condition(turn)
    puts "Game over! #{@players[turn].name} is in checkmate."
    @board.render
  end

end


if __FILE__ == $PROGRAM_NAME
  unless ARGV.empty?
    c = Chess.new(ARGV.shift, ARGV.shift)
  else
    c = Chess.new
  end
  c.play
end