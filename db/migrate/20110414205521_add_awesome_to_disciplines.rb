class AddAwesomeToDisciplines < ActiveRecord::Migration
  def self.up
    add_column :disciplines, :awesome, :boolean, :default => false
  end

  def self.down
    remove_column :disciplines, :awesome
  end
end