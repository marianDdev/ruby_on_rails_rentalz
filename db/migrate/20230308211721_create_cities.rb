class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|

      t.belongs_to :country, foreign_key: true
      t.string :name
      t.string :country_code
      t.timestamps
    end
  end
end
