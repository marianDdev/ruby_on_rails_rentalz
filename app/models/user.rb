class User < ApplicationRecord
    has_secure_password

    has_many :properties
    has_many :owner_bookings, class_name: 'Booking', foreign_key: 'owner_id'
    has_many :guest_bookings, class_name: 'Booking', foreign_key: 'guest_id'

    validates :email, presence: {message: "%{value} must be present"}, uniqueness: true
    validates :password, presence: {message: "%{value} must be super vasile"}
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :role, presence: true

    def owner? 
	  self.role == 'owner'
	end

    def guest?
        self.role == 'guest'
    end

end
