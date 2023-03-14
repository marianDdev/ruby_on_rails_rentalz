class Property < ApplicationRecord

    belongs_to :user
    has_many :bookings
    has_many_attached :images

    validates :name, presence: true
    validates :category, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["city", "country", "facilities", "name", "neighbourhood", "rating", ]
    end

    def self.ransackable_associations(auth_object = nil)
        ["bookings", "images_attachments", "images_blobs", "user"]
    end
end
