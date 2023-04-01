class RenameDeclineReasonToCommentFromBookings < ActiveRecord::Migration[7.0]
  def change
    rename_column :bookings, :decline_reason, :comment
  end
end
