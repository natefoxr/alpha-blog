class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.permit(:username, :email, :password))
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new'
    end
  end

end