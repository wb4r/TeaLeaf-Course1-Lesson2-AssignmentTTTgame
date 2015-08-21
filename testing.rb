require 'pry'
user_hand = ""
comp_hand = ""
players_inputs = {1=>" ", 2=>" ", 3=>" ", 4=>" ", 5=>" ", 6=>" ", 7=>" ", 8=>" ", 9=>" "}
win_results = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
user_choices = []
comp_choices = []
winner = !true
next_comp_move = []


# Creating players_inputs
def empty_positions(players_inputs)
  players_inputs.select {|_, position| position == ' ' }.keys
end


# Creating board display
def displaying_board(players_inputs)
  system 'clear'
  puts "     |     |     "
  puts "  #{players_inputs[1]}  |  #{players_inputs[2]}  |  #{players_inputs[3]}   "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{players_inputs[4]}  |  #{players_inputs[5]}  |  #{players_inputs[6]}   "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{players_inputs[7]}  |  #{players_inputs[8]}  |  #{players_inputs[9]}   "
  puts "     |     |     "
  puts "Choose a square: "
end


def user_input(players_inputs, user_hand, user_choices)
  user_hand = gets.chomp.to_i
  while empty_positions(players_inputs).index(user_hand) == nil
    puts "choose again"
    user_hand = gets.chomp.to_i
  end
  players_inputs[user_hand] = 'X'
  user_choices << user_hand
end 


# Computer input + offensive_AI
def computer_input(players_inputs, comp_hand, comp_choices, next_comp_move)
  if next_comp_move == []
    comp_hand = empty_positions(players_inputs).sample
  else
    comp_hand = next_comp_move.sample
  end
  players_inputs[comp_hand] = 'O'
  comp_choices << comp_hand
  comp_hand = 'O'
end


# Creating AI for when > 2 moves already done
def offensive(players_inputs, next_comp_move, win_results)
  players_inputs.each do |position, user_x|
  if user_x == 'X' 
    next_comp_move.delete(position)
  end
end 
  win_results.each_index do |win_line, _|
    if players_inputs[win_results[win_line][0]] == 'O' and players_inputs[win_results[win_line][1]] == 'O' and players_inputs[win_results[win_line][2]] != 'X'
      next_comp_move << win_results[win_line][2]
    elsif players_inputs[win_results[win_line][1]] == 'O' and players_inputs[win_results[win_line][2]] == 'O' and players_inputs[win_results[win_line][0]] != 'X'
      next_comp_move << win_results[win_line][0]
    elsif players_inputs[win_results[win_line][0]] == 'O' and players_inputs[win_results[win_line][2]] == 'O' and players_inputs[win_results[win_line][1]] != 'X'
      next_comp_move << win_results[win_line][1]
    end
  end
end

#Game loop
begin 
  empty_positions(players_inputs)
  displaying_board(players_inputs)
  user_input(players_inputs, user_hand, user_choices)
  offensive(players_inputs, next_comp_move, win_results)
  computer_input(players_inputs, comp_hand, comp_choices, next_comp_move)
  offensive(players_inputs, next_comp_move, win_results)
  
  # Breaking the loop if winner
  win_results.each_index do |position, _|
    if win_results[position] - user_choices == [] 
      winner = 'User'
    elsif win_results[position] - comp_choices == [] 
      winner = 'Computer'
    end
  end

end until empty_positions(players_inputs).empty? || winner


displaying_board(players_inputs)
puts "GAME OVER!! #{winner} won!"
