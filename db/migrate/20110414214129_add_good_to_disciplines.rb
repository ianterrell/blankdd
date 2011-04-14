class AddGoodToDisciplines < ActiveRecord::Migration
  def self.up
    add_column :disciplines, :good, :boolean, :default => false
    Discipline.where(:awesome => true).update_all(:good => true)
  end

  def self.down
    remove_column :disciplines, :good
  end
end