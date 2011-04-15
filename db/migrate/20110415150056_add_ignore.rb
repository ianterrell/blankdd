class AddIgnore < ActiveRecord::Migration
  def self.up
    add_column :disciplines, :ignore, :boolean, :default => false
    Discipline.all.each{|d|d.update_attribute :ignore, false}
  end

  def self.down
    remove_column :disciplines, :ignore
  end
end