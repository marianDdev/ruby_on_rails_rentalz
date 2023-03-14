class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)

        if @user.save
            session[:user_id] = @user.id
            redirect_to root_url
        else 
            render :new, status: :unprocessable_entity   
        end
    end

    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :password, :role)
        end
end
