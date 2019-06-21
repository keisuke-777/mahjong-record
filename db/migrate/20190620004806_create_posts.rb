class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :room_number
      t.integer :matches
      t.text :score_a
      t.text :score_b
      t.text :score_c
      t.text :score_d

      t.text :name_a
      t.text :name_b
      t.text :name_c
      t.text :name_d

      t.timestamps
    end
  end
end
