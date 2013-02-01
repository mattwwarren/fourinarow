class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :id
      t.string :name
      t.integer :color
      t.string :board
      t.string :playerone
      t.string :playertwo
      t.string :ponesession
      t.string :ptwosession

      t.timestamps
    end
  end
end
