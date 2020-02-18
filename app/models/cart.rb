class Cart

  def initialize(current_user)
    if current_user.present?
      if !current_user.cart.present?
        current_user.cart = Hash.new
        current_user.cart['products'] = Hash.new
        current_user.cart['total'] = 0
        current_user.cart['discount'] = nil
        current_user.save
      end
    end
  end

  def self.verify(current_user,out_of_stock,not_enough_stock)
    status = true
    products = Product.find(current_user.cart['products'].keys)
    products.each do |product|
      quantity = current_user.cart['products'][product.id.to_s].to_i
      if quantity > product.quantity and product.quantity == 0
        current_user.cart['total'] = current_user.cart['total'].to_f - (quantity * product.price)
        current_user.cart['products'].delete(product.id.to_s)
        out_of_stock.store(product.id,quantity)
        status = false
      elsif quantity > product.quantity and product.quantity != 0
        current_user.cart['total'] = (current_user.cart['total'].to_f - (quantity * product.price)) + product.quantity * product.price
        current_user.cart['products'].store(product.id,product.quantity)
        not_enough_stock.store(product.id,quantity)
        status = false
      end
    end
    current_user.save
    status
  end

  def self.empty(current_user)
    current_user.cart = Hash.new
    current_user.cart['products'] = Hash.new
    current_user.cart['total'] = 0
    current_user.cart['discount'] = nil
    current_user.save
  end

  def self.total(current_user,param_quantity,param_product_id,action)
    product = Product.find(param_product_id)
    total = current_user.cart['total'].to_f
    if product.quantity < param_quantity
      return nil
    elsif action == 'create'
      total = total + ( product.price.to_f * param_quantity)
    elsif action == 'update'
      product_old_qyt = current_user.cart['products'][param_product_id].to_i
      old_bill = product_old_qyt * product.price
      new_bill = param_quantity * product.price
      total = (total - old_bill) + new_bill
    elsif action == 'destroy'
      quantity = current_user.cart['products'][param_product_id].to_i
      bill = quantity * product.price
      total = total - bill
    end
  end
end
