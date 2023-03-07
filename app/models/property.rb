class Property < ApplicationRecord

    belongs_to :user
    has_one :booking
    has_many_attached :images

end
