class CartsController < ApplicationController
    before_action :set_product, only: [:create, :destroy]
    def create
        if !@current_cart
            @current_cart = Cart.create
            session[:current_cart_id] = @current_cart.secret_id
        end
        
        cart_item = @current_cart.cart_items.find_or_initialize_by(product_id: @product.id)
        cart_item.quantity += cart_item.new_record? ? 0 : 1
        cart_item.save
        redirect_back(fallback_location: products_path, notice: "Product added to your cart")
    end


end
