class UsersController < ApplicationController
  before_action :set_user, only: [:show,:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welocome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
     redirect_to current_user , notice: 'Account Updated.'
    else
     render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:region,:profile)
  end
  
  def set_user
     @user= User.find(params[:id])
  end
end
