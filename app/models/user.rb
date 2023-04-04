class User < ApplicationRecord
  has_secure_password

  has_many :properties
  has_many :owner_bookings, class_name: 'Booking', foreign_key: 'owner_id'
  has_many :guest_bookings, class_name: 'Booking', foreign_key: 'guest_id'
  has_many :messages
  has_many :reviews

  validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: /^(.+)@(.+)$/,
              message: 'Email invalid',
              multiline: true,
            },
            length: {
              minimum: 4,
              maximum: 254,
            }
  validates :password, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  def owner?
    self.role == 'owner'
  end

  def guest?
    self.role == 'guest'
  end

  def full_name
    self.first_name + ' ' + self.last_name
  end
end
