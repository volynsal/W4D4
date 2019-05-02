class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user
            login!(@user)
            redirect_to users_url
        else
            flash.now[:errors] = @users.error.full_messages
            render :new
        end
    end

    def show
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:email, :password_digest, :session_token)
    end

end