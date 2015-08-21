require 'pry'

class Board
  attr_accessor :players_inputs
  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  
  def initialize
    @players_inputs = {1=>" ", 2=>" ", 3=>" ", 4=>" ", 5=>" ", 6=>" ", 7=>" ", 8=>" ", 9=>" "}
  end  
  def players_inputs
    @players_inputs
  end  
  def empty_positions
    @players_inputs.select {|key, square| square == ' '}.keys
  end  
  def mark_square(position, marker)
    @players_inputs[position] = marker
  end
  def three_squares_in_a_row?(marker)
    WINNING_LINES.each do |line|      
      return true if @players_inputs[line[0]] == marker && @players_inputs[line[1]]  == marker && @players_inputs[line[2]] == marker
    end
    false
  end

  def displaying_board 
    system 'clear'
    puts "     |     |     "
    puts "  #{@players_inputs[1]}  |  #{@players_inputs[2]}  |  #{@players_inputs[3]}   "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@players_inputs[4]}  |  #{@players_inputs[5]}  |  #{@players_inputs[6]}   "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@players_inputs[7]}  |  #{@players_inputs[8]}  |  #{@players_inputs[9]}   "
    puts "     |     |     "
    puts "Choose a square: "
  end  
end

class Player
  attr_accessor :name, :marker
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end
=begin
class Square
  def initialize(value)
    @value = value
  end
  def value_empty?
    @value == ' '
  end 
  def mark(marker)
    @value = marker
  end
  def to_s
    @value 
  end
end
=end
class Game
  user_hand = ""
  comp_hand = ""
  user_choices = []
  comp_choices = []
  
  def initialize
    @human = Player.new("Bob", "X")
    @computer = Player.new("Computer", "O")
    @board = Board.new
    @current_player = @human
  end
  
  def play 
    @board.displaying_board
    begin
      alternate_player
      player_hand
      current_player_wins?
    end until @board.empty_positions.empty? || current_player_wins?
  end

  def current_player_wins?
    @board.three_squares_in_a_row?(@current_player.marker)
  end

  def player_hand
    if @current_player == @human 
      begin
        puts "choose a free position"
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
      marker = @human.marker
      @board.mark_square(position, marker)
      @board.displaying_board
    else
      position = @board.empty_positions.sample
      marker = @computer.marker
      @board.mark_square(position, marker)
      @board.displaying_board
    end
  end

  def alternate_player
    if @current_player == @human 
      @current_player = @computer
    else
      @current_player = @human 
    end
  end
end

new_game = Game.new.play
