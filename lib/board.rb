class Board
  attr_reader :winner
  def initialize
    @positions = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
    @move_number = 0
    @winner = false
  end

  def get_board
    "\n #{@positions[0][0]} | #{@positions[0][1]} | #{@positions[0][2]} \n"\
    "----------- \n"\
    " #{@positions[1][0]} | #{@positions[1][1]} | #{@positions[1][2]} \n"\
    "----------- \n"\
    " #{@positions[2][0]} | #{@positions[2][1]} | #{@positions[2][2]} \n"
  end

  def move(x_pos, y_pos, mark)
    @positions[x_pos][y_pos] = mark
    @move_number += 1
    check_winner(x_pos, y_pos, mark) if @move_number > 4
  end

  def check_winner(x_pos, y_pos, mark)
    @winner = check_row(x_pos, mark)
    return @winner if @winner

    @winner = check_col(y_pos, mark)
    return @winner if @winner

    @winner = check_diagonals(x_pos, y_pos, mark) if x_pos == y_pos || (x_pos - y_pos).abs == 2
  end

  def reset_board
    @positions = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
    @move_number = 0
    @winner = false
  end

  private

  def check_row(y_pos, mark)
    @positions[y_pos].all? { |i| i == mark }
  end

  def check_col(x_pos, mark)
    @positions.all? { |i| i[x_pos] == mark }
  end

  def check_diagonals(x_pos, y_pos, mark)
    if (x_pos - y_pos).abs == 2
      j = 2
      3.times do |i|
        return false unless @positions[i][j] == mark

        j -= 1
      end
      return true
    end

    3.times { |i| return false unless @positions[i][i] == mark }
    true
  end
end
