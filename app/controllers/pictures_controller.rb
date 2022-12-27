class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    elsif @picture.save
      PictureMailer.picture_mail(@picture).deliver
      redirect_to new_picture_path, notice: "投稿しました！"
    else
      render :new
    end
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice: "削除しました"
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  private
  
  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_user
    @pictures = current_user.pictures
    @picture = @pictures.find_by(id: params[:id])
    redirect_to pictures_path, notice: "編集または削除できません" unless @picture
  end
end