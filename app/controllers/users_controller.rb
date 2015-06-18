class UsersController < ApplicationController

  def index
    # for admin - to see all users
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # link user to account (where we come from) -> comes from the session cookie!!
    # current_account is sth you can use everywhere withi the session
     # works because we are somewhere where we need a login (before_action in application controller), so there's always a session linked to an account
     # with account because we did devise on account
    @user.account = current_account
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end


  protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :picture)

  end
end
