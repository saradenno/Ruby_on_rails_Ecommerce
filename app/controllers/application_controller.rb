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

  def set_current_cart
    if session[:current_cart_id]
      @current_cart = Cart.find_by_secret_id(session[:current_cart_id])
      
      # Associate the cart with the user if not already associated
      if current_user && @current_cart && @current_cart.user_id.nil?
        @current_cart.update(user_id: current_user.id)
      end
  
    elsif current_user && current_user.carts.any?
      # If the user is logged in and has existing carts, load the latest cart
      @current_cart = current_user.carts.last
      session[:current_cart_id] = @current_cart.secret_id
    end
    end
  end