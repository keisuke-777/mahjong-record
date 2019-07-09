class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :pass
      t.integer :rate
      t.integer :winning
      t.integer :matches
      t.integer :total_score
      t.integer :money

      t.timestamps
    end
  end
end