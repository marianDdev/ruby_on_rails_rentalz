class Booking < ApplicationRecord
    belongs_to :owner, class_name: 'User'
    belongs_to :guest, class_name: 'User'
    belongs_to :property

    @today = Date.today

    def has_reason?
        self.status == 'declined' && self.decline_reason != nil
    end

    def approved?
        self.status == 'approved'
    end

    def reviewable?
        self.is_reviewed == false && self.approved?
    end
end
