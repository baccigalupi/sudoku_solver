require 'rubygems'
require 'rspec'

require File.dirname(__FILE__) + "/sudoku"

describe Sudoku do
  let(:game) { Sudoku.new(4,5) }

  describe 'initialization' do
    it 'stores the columns size' do
      game.columns.should == 4
    end

    it 'stores the rows size' do
      game.rows.should == 5
    end
  end

  describe '#populate' do
    it "creates the right number of cells" do
      Sudoku::Cell.should_receive(:new).exactly(20).times
      game.populate
    end

    it "stores the newly created cells in 'cells'" do
      game.populate
      game.cells.size.should == 20
    end

    it "cells have the rows and columns" do
      game.populate

      cell = game.cells[0]

      cell.row.should == 1
      cell.column.should == 1

      cell = game.cells[15]
      cell.row.should == 4
      cell.column.should == 4
    end

    it "correctly calculates the block" do
      game.populate

      game.cells[0].block.should == 1
      game.cells[2].block.should == 1
      game.cells[5].block.should == 1

      game.cells[3].block.should == 2
      game.cells[7].block.should == 2

      game.cells[12].block.should == 3
      game.cells[15].block.should == 4
    end
  end

  describe "#to_array" do
    before do
      game.populate
    end

    it "should return an array" do
      game.to_array.class.should == Array
    end

    it "has the length of the columns multiplied by the rows" do
      game.to_array.size.should == 20
    end

    it "should contain the values of all the cells" do
      pending 'need to implement populate to build our cells'
      game.cells.map{|c| c.value}.should == game.to_array
    end
  end
end

describe Sudoku::Cell do
  let(:cell) {
    Sudoku::Cell.new({
      row: 0,
      column: 3,
      block: 1
    })
  }

  describe '#initialize' do
    it "stores the row" do
      cell.row.should == 0
    end

    it "stores the column" do
      cell.column.should == 3
    end

    it 'stores the block' do
      cell.block.should == 1
    end

    it "starts with an empty array as the #rejected_numbers" do
      cell.rejected_numbers.should == []
    end
  end

  describe 'the value' do
    it 'can be read' do
      cell.value.should == nil
      cell.instance_variable_set('@value', 6)
      cell.value.should == 6
    end

    it 'can be set' do
      cell.value = 9
      cell.value.should == 9
    end
  end

  describe '#reject(n)' do
    it 'adds it to the rejected_numbers array' do
      cell.rejected_numbers.should be_empty

      cell.reject(3)
      cell.rejected_numbers.should == [3]

      cell.reject(8)
      cell.rejected_numbers.should == [3,8]
    end
  end
end
