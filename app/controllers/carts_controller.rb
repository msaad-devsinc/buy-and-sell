class CartsController < ApplicationController
  def show
  	@cart = current_user.cart
    puts 'aaaaaaaaaaaaaaa'
    puts @cart
  	@products = Product.find(@cart['products'].keys)
  end

  def create
  	# product_id key
  	# product quantity values

  	@total = current_user.cart['total'].to_f
  	@product = Product.find(params[:cart][:product_id] )
  	@total = @total + ( @product.price.to_f * params[:cart][:quantity].to_i)

  	current_user.cart.store('total',@total)
  	current_user.cart['products'].store(params[:cart][:product_id] ,params[:cart][:quantity])
  	
  	current_user.save
  	respond_to do |format|
  		format.js
  	end
  end

  def update
  	# product_id key
  	# product quantity value
  	@total = current_user.cart['total'].to_f
  	@product_old_qyt = current_user.cart['products'][params[:cart][:product_id]].to_i
  	@product = Product.find(params[:cart][:product_id])

  	old_bill = @product_old_qyt * @product.price

  	new_bill = params[:cart][:quantity].to_i * @product.price
  	
  
  	@total = (@total - old_bill) + new_bill

  	current_user.cart['total'] = @total
  	current_user.cart['products'].store(params[:cart][:product_id] ,params[:cart][:quantity])
  	current_user.save

  	respond_to do |format|
  		format.js
  	end
  end

  def destroy
    quantity = current_user.cart['products'][params[:cart][:product_id]].to_i

    @product = Product.find(params[:cart][:product_id])

    bill = quantity * @product.price

    total = current_user.cart['total'].to_f

    @total = total - bill

    current_user.cart['products'].delete(params[:cart][:product_id])
    current_user.cart['total'] = @total
    current_user.save

    respond_to do |format|
      format.js
    end
  end
end
