class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :pass
      t.integer :rate
      t.integer :winning
      t.integer :matches
      t.integer :ave_score

      t.timestamps
    end
  end
end
