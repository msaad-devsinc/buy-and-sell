class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home,:index]
  before_action :set_product, only: [:show]
  before_action :set_user_product, only: [:edit, :update, :destroy]

  def index
    if params[:search].present?
      @products = Product.search(params[:search][:query])
    else
      @products = Product.all
    end
  end

  def show
    @comment = Comment.new
    @comments = @product.comments
  end

  def create
    @product = current_user.products.create(product_params)
     if @product.save
      redirect_to products_path
     else
      render :new
     end
  end

  def new
  	@product = Product.new
  end

  def edit
  end

  def update
    @product.update(product_params)
  	if @product.save
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  def home
    Cart.new(current_user)
    session[:out_of_stock] = Hash.new
    session[:not_enough_stock] = Hash.new
  end

  private
    def set_product
      @product = Product.find_by(id:params[:id]) or not_found
    end
    def set_user_product
      @product = Product.find_by(id:params[:id])
      if @product.blank?
        not_found
      else
        if @product.user != current_user
          flash[:alert] = 'you can only edit your own product'
          redirect_to account_path
        end
      end
    end
    def product_params
      params.require(:product).permit(:title,:category,:description,:price,:quantity,images: [])
    end
    def not_found
      flash[:alert] = 'Product not found'
      redirect_to products_path
    end
end
