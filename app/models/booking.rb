class Booking < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :guest, class_name: 'User'
  belongs_to :property

  PENDING_STATUS = 'pending'
  APPROVED_STATUS = 'approved'
  DECLINED_STATUS = 'declined'

  validates :status,
            presence: true,
            inclusion: {
              in: %w[pending approved declined],
              message: '%{value} is not a valid booking status',
            }

  validates :guests_count, :start_at, :end_at, presence: true

  validate :validate_checkout_after_checkin

  validate :validate_checkin_olther_than_today

  def has_comment?
    self.comment != nil
  end

  def approved?
    self.status == APPROVED_STATUS
  end

  def reviewable?
    self.is_reviewed == false && self.approved?
  end

  private

  def validate_checkout_after_checkin
    return if end_at.blank? || start_at.blank?

    if end_at < start_at
      errors.add(:end_at, '- Checkout date must be greater than check-in date')
    end
  end

  def validate_checkin_olther_than_today
    return if end_at.blank? || start_at.blank?

    if start_at < Date.today
      errors.add(:start_at, '- Check-in date must be in future')
    end
  end
end
