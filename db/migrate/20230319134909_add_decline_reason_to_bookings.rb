class AddDeclineReasonToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :decline_reason, :text
  end
end
