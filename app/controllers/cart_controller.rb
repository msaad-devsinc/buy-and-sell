class CartController < ApplicationController
  before_action :set_cart_data ,only: [:show]
  before_action :calculate_total ,only: [:create,:update,:destroy]

  def show
  end

  def create
    @product = Product.find(params[:cart][:product_id])
  	current_user.cart.store('total',@total)
    # current_user.cart['line-items']
  	current_user.cart['products'].store(params[:cart][:product_id] ,params[:cart][:quantity])
  	current_user.save
  end

  def update
  	current_user.cart['total'] = @total
  	current_user.cart['products'].store(params[:cart][:product_id] ,params[:cart][:quantity])
  	current_user.save
  end

  def destroy
    @product_id = params[:cart][:product_id]
    current_user.cart['products'].delete(params[:cart][:product_id])
    current_user.cart['total'] = @total
    current_user.save
  end

  private

  def set_cart_data
    @cart = current_user.cart
    @products = Product.find(@cart['products'].keys)
    if session[:out_of_stock].present?
      @out_of_stock_products = Product.find(session[:out_of_stock].keys)
    end
  end

  def calculate_total
    @total = Cart.total(current_user,params[:cart][:quantity].to_i,params[:cart][:product_id],params['action'])
    if @total.blank?
      flash[:alert] = 'Not enough stock'
      redirect_to products_path
    end
  end
end
