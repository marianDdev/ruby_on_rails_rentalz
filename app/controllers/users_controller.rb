class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)

        if @user.save
            session[:user_id] = @user.id
            flash[:success] = 'User has been created.'
            redirect_to root_url
        else 
            flash.now[:alert] = "User couldn't be created!"
            render :new    
        end
    end

    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :password, :role)
        end
end
