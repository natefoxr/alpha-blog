class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 6)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(params.require(:user).permit(:username, :email, :password))
      flash[:success] = "Account was updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password))
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to @user
    else
      render 'new'
    end
  end

  private # private should always be toward the bottom of your code
  def set_user
    @user = User.find(params[:id])
  end

end
