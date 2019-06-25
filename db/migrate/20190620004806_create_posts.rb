class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :room_number
      t.integer :matches
      t.integer :matches_a
      t.integer :matches_b
      t.integer :matches_c
      t.integer :matches_d
      t.integer :priority3
      t.integer :priority2
      t.integer :priority1

      t.integer :uma
      t.float :rate
      t.integer :buck
      t.text :hako
      t.text :tobi
      t.text :yakitori
      t.text :yakuman
      t.text :rule
      t.boolean :finish

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
