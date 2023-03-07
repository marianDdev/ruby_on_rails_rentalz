class User < ApplicationRecord

    has_secure_password

    has_many :properties
    has_many :owner_bookings, class_name: 'Booking', foreign_key: 'owner_id'
    has_many :guest_bookings, class_name: 'Booking', foreign_key: 'guest_id'

    def owner? 
	  self.role == 'owner'
	end

    def guest?
        self.role == 'guest'
    end

    

end
