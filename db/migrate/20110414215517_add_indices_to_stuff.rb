class AddIndicesToStuff < ActiveRecord::Migration
  def self.up
    add_index :disciplines, :expanded
  end

  def self.down
    remove_index :disciplines, :expanded
  end
end