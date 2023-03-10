class Property < ApplicationRecord

    belongs_to :user
    has_many :bookings
    has_many_attached :images

    def self.ransackable_attributes(auth_object = nil)
        ["city", "country", "facilities", "name", "neighbourhood", "rating"]
    end
end
