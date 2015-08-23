

class Board
  attr_accessor :players_inputs
  WIN_ARRAYS = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  
  def initialize
    @players_inputs = {1=>" ", 2=>" ", 3=>" ", 4=>" ", 5=>" ", 6=>" ", 7=>" ", 8=>" ", 9=>" "}
  end
  
  def empty_positions
    @players_inputs.select {|_, square| square == ' '}.keys
  end
  
  def mark_square(position, symbol)
    @players_inputs[position] = symbol
  end
  
  def three_squares?(symbol)
    WIN_ARRAYS.each do |combo|      
      return true if @players_inputs[combo[0]] == symbol && @players_inputs[combo[1]]  == symbol && @players_inputs[combo[2]] == symbol
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
  attr_reader :name, :symbol 
  
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
  
  def to_s
    "#{self.name}"
  end
end


class Game
  attr_reader :name, :symbol
  
  def initialize
    @human = Player.new("Human", "X")
    @computer = Player.new("Computer", "O")
    @current_player = @human
  end
  
  def alternate_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end
  
  def choose_square(current_player)
    if @current_player == @human
      begin
        puts "Please, choose an empty square: "
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
      
    else
      position = @board.empty_positions.sample
    end
      symbol = @current_player.symbol
      @board.mark_square(position, symbol)
      @board.displaying_board
  end
  
  
  
  
  def current_player_wins?(current_player)
    if @board.three_squares?(@current_player.symbol)
      puts "#{@current_player} wins!!"
    end
  end

  def its_a_tie?
    if @board.three_squares?(@current_player.symbol) == false && @board.empty_positions.empty?
      puts "It's a tie!"
    end
  end




  def replay?
    puts ""
    puts "Do you want to play again?"
    replay = gets.downcase.chomp
    if replay == 'y'
      play
    else
      puts "Good bye!"
    end
  end

  def play
    @board = Board.new
    begin 
      alternate_player 
      @board.displaying_board
      choose_square(@current_player)
      current_player_wins?(@current_player)
      its_a_tie?
    end until @board.empty_positions.empty? || @board.three_squares?(@current_player.symbol)
    replay?
  end
end

new_game = Game.new.play