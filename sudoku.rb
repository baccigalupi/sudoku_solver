class Sudoku
  attr_accessor :columns, :rows, :cells

  def initialize x , y
    self.columns = x
    self.rows = y
    self.cells = []
  end

  def populate
    i = 1
    (1..rows).to_a.each do |row|
      (1..columns).to_a.each do |col|
        block_index = i - ((row-1)*columns) - 1
        fudge_factor = (i >= 12) ? 2 : 0
        block = ((block_index)/3 < 1 ? 1 : 2) + fudge_factor
        self.cells << Cell.new({
          row: row,
          column: col,
          block: block
        })
        i = i + 1
      end
    end
  end

  def to_array
    Array.new columns * rows
  end

  class Cell
    attr_accessor :row, :column, :block, :value, :rejected_numbers

    def initialize opts
      self.row = opts[:row]
      self.column = opts[:column]
      self.block = opts[:block]
      self.rejected_numbers = []
    end

    def reject(n)
      rejected_numbers << n
    end
  end
end
