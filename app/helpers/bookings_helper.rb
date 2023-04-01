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
end
