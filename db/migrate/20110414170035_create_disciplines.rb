class CreateDisciplines < ActiveRecord::Migration
  def self.up
    create_table :disciplines do |t|
      t.string :initial, :limit => 1
      t.string :expanded, :downcased, :tagline
      t.timestamps
    end
  end

  def self.down
    drop_table :disciplines
  end
end
