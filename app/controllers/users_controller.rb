class UsersController < ApplicationController
  before_action :authenticate, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Logged in successfully'
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    puts params
    @user = current_user

    if @user.update(user_params)
        redirect_to projects_path
    else
        render 'edit'
    end
  end

  def destroy
    current_user.destroy
    session[:user_id] = nil
    redirect_to logout_path, notice: 'Account deleted successfully.'
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

end
