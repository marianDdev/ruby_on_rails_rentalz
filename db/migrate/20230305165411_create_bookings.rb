class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|

      t.references :guest
      t.references :owner
      t.references :property
      t.date :start_at
      t.date :end_at
      t.integer :guests_count
      t.string :status
      t.timestamps
    end
    add_foreign_key :bookings, :users, column: :owner_id, primary_key: :id
    add_foreign_key :bookings, :users, column: :guest_id, primary_key: :id
  end
end
