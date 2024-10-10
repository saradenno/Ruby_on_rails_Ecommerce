class ApplicationController < ActionController::Base
  before_action :set_current_cart

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # only else case is inheritnce
  protected 
  def check_admin_priv
    if !current_admin
      redirect_to root_path
    end
  end

  private 
  def set_current_cart
    if session[:current_cart_id]
        @current_cart= Cart.find_by_secret_id(session[:current_cart_id])
    else 
        @current_cart=Cart.create
        session[:current_cart_id]=@current_cart.secret_id
    end
  end
end
