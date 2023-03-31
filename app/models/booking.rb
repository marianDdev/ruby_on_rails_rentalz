class Booking < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :guest, class_name: 'User'
  belongs_to :property

  @today = Date.today

  validates :status,
            presence: true,
            inclusion: {
              in: %w[pending approved declined],
              message: '%{value} is not a valid booking status',
            }

  def has_reason?
    self.status == 'declined' && self.comment != nil
  end

  def approved?
    self.status == 'approved'
  end

  def reviewable?
    self.is_reviewed == false && self.approved?
  end
end
