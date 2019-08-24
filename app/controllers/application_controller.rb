class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = session[:user_id] ? User.find(session[:user_id]) : nil
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map do |product| 
      { product: product, quantity: cart[product.id.to_s] }
    end
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map do |entry| 
      entry[:product].price_cents * entry[:quantity]
    end.sum
  end
  helper_method :cart_subtotal_cents


  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

end
