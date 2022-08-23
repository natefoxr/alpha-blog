class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "You have created the #{@category.name} category"
      redirect_to @category
    else
      render 'new'
    end
  end

  def index 
    @categories = Category.paginate(page: params[:page], per_page: 6)
  end

  def show
    @category = Category.find(params[:id])
  end

  private # private should always be toward the bottom of your code
  def category_params
    params.require(:category).permit(:name)
  end

end