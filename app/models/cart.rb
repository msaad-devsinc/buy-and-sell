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
