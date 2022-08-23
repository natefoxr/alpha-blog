class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
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
    if @user.update(user_params)
      flash[:success] = "Account was updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy if !@user.admin?
    if !current_user.admin?
      session[:user_id] = nil
    end
    flash[:notice] = "Account and all associated articles have been successfully deleted"
    redirect_to root_path, status: :see_other
  end

  private # private should always be toward the bottom of your code
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own profile"
      redirect_to user_path(current_user)
    end
  end

end
