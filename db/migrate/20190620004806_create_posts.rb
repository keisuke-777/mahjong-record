class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :room_number
      t.integer :matches
      t.integer :matches_a
      t.integer :matches_b
      t.integer :matches_c
      t.integer :matches_d
      
      t.text :priority3
      t.text :priority2
      t.text :priority1

      t.integer :uma
      t.float :rate
      t.integer :buck
      t.text :hako
      t.text :tobi
      t.integer :tobi_score
      t.text :yakitori
      t.integer :yakitori_score
      t.text :yakuman
      t.integer :yakuman_score
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
