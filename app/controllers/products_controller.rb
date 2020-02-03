class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :initialize_cart, only: [:index,:show]

  def index
    # @cart = current_user.cart
    @products = Product.all
  end

  def show
    @comment = Comment.new
    @comments = Product.find(params[:id]).comments
  end

  def create
     # @product = Product.new(product_params)
     if current_user.products.create(product_params)
      redirect_to :index
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
  	if @product.update(product_params)
      redirect_to :index
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to :index
  end

  private
    def find_product
      @product = Product.find(params[:id])
    end
     def product_params
      params.require(:product).permit(:title,:category,:description,:price,:quantity,images: [])
    end

    def initialize_cart
      if !current_user.cart.present?
        current_user.cart = Hash.new
        current_user.cart['products'] = Hash.new
        current_user.cart['total'] = 0
        current_user.save
      end
    end
end
