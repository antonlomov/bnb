class UsersController < ApplicationController

  def index
    # for admin - to see all users
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    # @errors = [] # for passing it in the render
  end

  # def create
  #   # FIXING BUG - replacing by creation of new user with test values
  #   # @user = User.new(user_params)
  #   @user = User.new(first_name: "first name", last_name: "last name")
  #   # link user to account (where we come from) -> comes from the session cookie!!
  #   # current_account is sth you can use everywhere withi the session
  #    # works because we are somewhere where we need a login (before_action in application controller), so there's always a session linked to an account
  #    # with account because we did devise on account
  #   @user.account = current_account
  #   if @user.save
  #     # FIXING BUG - replacing by going to edit user instead of to show user, as test values only now
  #     # redirect_to user_path(@user)
  #     redirect_to edit_user_path(@user)
  #   else
  #     render :new
  #   end
  # end

  def edit
    @user = User.find(params[:id])
    # @errors = [] # for passing it in the render to form in the view
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end


  protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :picture)

  end
end
