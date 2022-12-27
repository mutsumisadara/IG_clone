class UsersController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
          redirect_to user_path(@user.id)
        else
          render :new
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
        unless @user.id = current_user.id
          redirect_to  new_post_path
        end
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          redirect_to user_path, notice: "編集しました！"
        else
          render :edit
        end
    end

    def set_image
      @user = User.find(params[:id])
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def image_params
      params.require(:user).permit(:image, :image_cache)
    end
end