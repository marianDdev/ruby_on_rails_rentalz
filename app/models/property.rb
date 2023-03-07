class Property < ApplicationRecord

    belongs_to :user
    has_many :booking
    has_many_attached :images

end
