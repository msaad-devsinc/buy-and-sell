class Cart
  def cal_total
    total = current_user.cart['total'].to_f
    product = Product.find(params[:cart][:product_id] )
    total = total + ( product.price.to_f * params[:cart][:quantity].to_i)
  end

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
end
