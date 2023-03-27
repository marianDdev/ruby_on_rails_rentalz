class AddIsReviewedToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :is_reviewed, :boolean, :default => false
  end
end
