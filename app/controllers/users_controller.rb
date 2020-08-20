class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:new, :create]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @users = User.all
    end

    def show
        @posts = @user.posts
    end

    def new
        @user = User.new
    end

    def edit
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome #{@user.username}, you have successfully signed up"
            redirect_to @user
        else
            render 'new'
        end
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Your account information was successfully updated"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:notice] = "Account and all associated posts successfully deleted"
        redirect_to root_path
    end

    private

    def user_params
        params.require(:user).permit(:username, :profile, :profile_cache, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "You can only edit your own account"
            redirect_to @user
        end
    end
end
