class Property < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :images

  @countries = Country.pluck(:name)
  @cities = City.pluck(:name)

  validates :name, presence: true
  validates :category, presence: true
  validates :city,
            presence: true,
            inclusion: {
              in: @cities,
              message: '%{value} is not a valid city name',
            }
  validates :country,
            presence: true,
            inclusion: {
              in: @countries,
              message: '%{value} is not a valid country name',
            }

  def self.ransackable_attributes(auth_object = nil)
    %w[city country facilities name neighbourhood rating]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[bookings images_attachments images_blobs user]
  end

  def rating
    self.reviews.average(:rating)
  end

  def reviews_count
    self.reviews.count
  end
end
