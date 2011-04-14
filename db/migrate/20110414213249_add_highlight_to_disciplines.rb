class AddHighlightToDisciplines < ActiveRecord::Migration
  def self.up
    add_column :disciplines, :highlight, :boolean, :default => false
  end

  def self.down
    remove_column :disciplines, :highlight
  end
end