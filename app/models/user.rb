class User < ApplicationRecord

    has_secure_password

    has_many :properties

    def owner? 
	  self.role == 'owner'
	end

    def guest?
        self.role == 'guest'
    end

end
