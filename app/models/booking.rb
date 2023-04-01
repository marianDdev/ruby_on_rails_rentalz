class Booking < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :guest, class_name: 'User'
  belongs_to :property

  @today = Date.today

  PENDING_STATUS = 'pending'
  APPROVED_STATUS = 'approved'
  DECLINED_STATUS = 'declined'

  validates :status,
            presence: true,
            inclusion: {
              in: %w[pending approved declined],
              message: '%{value} is not a valid booking status',
            }

  def has_reason?
    self.status == DECLINED_STATUS && self.comment != nil
  end

  def approved?
    self.status == APPROVED_STATUS
  end

  def reviewable?
    self.is_reviewed == false && self.approved?
  end
end
