class Property < ApplicationRecord

    belongs_to :user, optional: true
    has_many_attached :images

end
