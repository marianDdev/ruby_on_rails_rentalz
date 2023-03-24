class Property < ApplicationRecord

    belongs_to :user
    has_many :bookings
    has_many :reviews
    has_many_attached :images

    @countries = Country.pluck(:name)
    @cities = City.pluck(:name)

    validates :name, presence: true
    validates :category, presence: true
    validates :city, presence: true, inclusion: {in: @cities,  message: "%{value} is not a valid city name" }
    validates :country, presence: true, inclusion: {in: @countries,  message: "%{value} is not a valid country name" }

    def self.ransackable_attributes(auth_object = nil)
        ["city", "country", "facilities", "name", "neighbourhood", "rating", ]
    end

    def self.ransackable_associations(auth_object = nil)
        ["bookings", "images_attachments", "images_blobs", "user"]
    end
end
