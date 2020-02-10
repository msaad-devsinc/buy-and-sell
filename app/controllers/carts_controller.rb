class CartsController < ApplicationController
  before_action :set_cart_data ,only: [:show]
  before_action :create_total ,only: [:create]
  before_action :update_total ,only: [:update]
  before_action :destroy_total ,only: [:destroy]
  def show
  end

  def create
  	# product_id key
  	# product quantity values
  	current_user.cart.store('total',@total)
  	current_user.cart['products'].store(params[:cart][:product_id] ,params[:cart][:quantity])
  	current_user.save
  end

  def update
  	# product_id key
  	# product quantity value
  	current_user.cart['total'] = @total
  	current_user.cart['products'].store(params[:cart][:product_id] ,params[:cart][:quantity])
  	current_user.save
  end

  def destroy
    current_user.cart['products'].delete(params[:cart][:product_id])
    current_user.cart['total'] = @total
    current_user.save
  end
  private
    def set_cart_data
      @cart = current_user.cart
      @products = Product.find(@cart['products'].keys)
    end
    def create_total
      @total = current_user.cart['total'].to_f
      @product = Product.find(params[:cart][:product_id] )
      @total = @total + ( @product.price.to_f * params[:cart][:quantity].to_i)
    end
    def update_total
      @total = current_user.cart['total'].to_f
      @product_old_qyt = current_user.cart['products'][params[:cart][:product_id]].to_i
      @product = Product.find(params[:cart][:product_id])
      old_bill = @product_old_qyt * @product.price
      new_bill = params[:cart][:quantity].to_i * @product.price
      @total = (@total - old_bill) + new_bill
    end
    def destroy_total
      quantity = current_user.cart['products'][params[:cart][:product_id]].to_i
      @product = Product.find(params[:cart][:product_id])
      bill = quantity * @product.price
      total = current_user.cart['total'].to_f
      @total = total - bill
      if current_user.cart['products'].length == 1
       current_user.cart['discount'] = nil
      end
    end
end
