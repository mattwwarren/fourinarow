class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :id
      t.string :name
      t.enum :color
      t.string :board

      t.timestamps
    end
  end
end
