class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :id
      t.string :name
      t.enum :color
      t.string :board

      t.timestamps
    end
  end
end
