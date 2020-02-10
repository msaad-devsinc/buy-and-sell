class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search].present?
      @products = Product.search(params[:search][:query])

    else
      @products = Product.where("quantity > '0'")
    end
  end

  def show
    @comment = Comment.new
    @comments = @product.comments
  end

  def create
     # @product = Product.new(product_params)
     if current_user.products.create(product_params)
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
  	if @product.update(product_params)
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
    Cart.initialize_cart(current_user)
  end

  private
    def find_product
      @product = Product.find_by(id:params[:id]) or not_found
    end
     def product_params
      params.require(:product).permit(:title,:category,:description,:price,:quantity,images: [])
    end
    def not_found
      render :file => "/public/404.html",  :status => 404
    end
end
