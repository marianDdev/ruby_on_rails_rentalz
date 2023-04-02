module BookingsHelper
  def current_user_owns_property(booking)
    current_user.id == booking.owner_id
  end

  def link_text
    if current_user.owner?
      'Approve or Decline'
    elsif current_user.guest?
      'Edit'
    end
  end

  def link_path(booking)
    if link_text == 'Approve or Decline'
      booking.id.to_s + '/edit_status'
    elsif link_text == 'Edit'
      booking.id.to_s + '/edit'
    end
  end

  def display_image(booking)
  end

  def belongs_to_current_user(booking)
    current_user.id == booking.guest_id
  end

  def is_current_or_past_booking(booking)
    @today = Date.today
    booking.end_at < @today ||
      booking.start_at <= @today && booking.end_at > @today
  end

  def reviewable(booking)
    booking.is_reviewed == false && booking.status == 'approved' &&
      belongs_to_current_user(booking) && is_current_or_past_booking(booking)
  end
end
