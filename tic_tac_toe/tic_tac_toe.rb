# https://github.com/TheOdinProject/curriculum/blob/master/ruby_programming/intermediate_ruby/project_oop.md
Player = Struct.new(:name, :fill)

class Game
  attr_accessor :board, :player, :finished, :winner, :played
  LINES = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

  def initialize
    @board = (0..8).inject([]) { |acc, n| acc << n }
  end

  def show_board
    board_lines.each { |line| p line }
  end

  def check_result
    self.finished = true if win? || all_filled?
    self.winner = player if win?
  end

  def play(coord)
    if already_filled?(coord)
      render_error_already_filled
      show_board
      return
    end

    board[coord] = player.fill
    self.played = true
  end

  def announce_result
    return puts "The winner is #{winner.name} !!!" if winner

    puts 'The game is over: DRAW'
  end

  private

  def all_filled?
    board.none?(Integer)
  end

  def render_error_already_filled
    puts 'This cell has already been filled'
  end

  def already_filled?(coord)
    board[coord].is_a? String
  end

  def win?
    LINES.include? player_indexes
  end

  def board_lines
    board.each_slice(3).to_a
  end

  def player_indexes
    indexes = []
    board.each_with_index do |cell, index|
      indexes << index if cell == player.fill
    end

    indexes
  end
end

player1 = Player.new('Guillaume', 'X')
player2 = Player.new('Plop', 'O')
game = Game.new

current_player = [player1, player2].sample
until game.finished do
  game.show_board
  current_player = current_player == player1 ? player2 : player1
  game.played = false
  until game.played do
    puts "#{current_player.name} (#{current_player.fill}), please choose a cell: "
    game.player = current_player
    cell = gets.chomp.to_i
    game.play(cell)
  end
  game.check_result
end

game.announce_result
