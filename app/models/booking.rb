class Booking < ApplicationRecord
    belongs_to :owner, class_name: 'User'
    belongs_to :guest, class_name: 'User'
    belongs_to :property

    def has_reason?
        self.status == 'declined' && self.decline_reason != nil
    end
end
