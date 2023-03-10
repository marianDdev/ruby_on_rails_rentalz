class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|

      t.belongs_to :user, foreign_key: true
      t.string :category
      t.string :country
      t.string :city
      t.string :neighbourhood
      t.string :name
      t.text :description
      t.text :facilities
      t.float :rating, null: true
      t.integer :reviews, null: true 
      t.integer :guests
      t.integer :bedrooms
      t.integer :beds
      t.integer :baths
      t.integer :price
      t.string :currency
      t.boolean :is_available
      t.timestamps
    end
  end
end
