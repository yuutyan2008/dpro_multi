class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :user_params, only: [:create, :update]
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)


    if @user.save
      log_in(@user)
      # UserMailerでメールを非同期送信
      UserMailer.registration_confirmation(@user).deliver_later

      redirect_to user_path(@user.id), notice: 'アカウントを登録しました。'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    # binding.irb
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image)

  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user?(@user)
  end
end
