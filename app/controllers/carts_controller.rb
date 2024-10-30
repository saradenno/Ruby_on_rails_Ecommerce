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



    def update
        @cart_item = @current_cart.cart_items.find(params[:id])
        new_quantity = params[:quantity].to_i
      
        if new_quantity > 0
          @cart_item.update(quantity: new_quantity)
        else
          @cart_item.destroy
        end
      
        redirect_to cart_path(@current_cart), notice: "Cart updated"
    end


    def show
    end 


    def checkout
        if !@current_cart&.cart_items&.any?
            redirect_to root_path, notice: "You dont have any items in cart yet !"
        end
    end


    def destroy
        @cart_item= @current_cart.cart_items.find_by_product_id(@product.id)
        @cart_item.destroy
        redirect_to cart_path(@current_cart)
    end



    def stripe_session
        session = Stripe::Checkout::Session.create({
        ui_mode: 'embedded',
        line_items: @current_cart.cart_items.map do |cart_item|{
            # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
            price_data: {
              currency: "usd",
              unit_amount: (cart_item.product.price * 100).to_i,
              product_data: {
                name: @current_cart.products.map(&:name).join(", "),
              },
            },
            quantity: cart_item.quantity,
          }
        end,

          shipping_address_collection:{
            allowed_countries: STRIPE_SUPPORTED_COUNTRIES
          },
          
          mode: 'payment',
          return_url: success_cart_url(@current_cart.secret_id),
      })
  
      render json: { clientSecret: session.client_secret } 
    end 

    def success
      if @current_cart.cart_items.any?
        session[:current_cart_id] = nil
    
        @current_cart.cart_items.each do |cart_item|
          if cart_item.product.stock >= cart_item.quantity
            Order.create!(product: cart_item.product, quantity: cart_item.quantity, total_price: cart_item.product.price * cart_item.quantity, user_id: current_user&.id)
            cart_item.product.update(stock: cart_item.product.stock - cart_item.quantity)
          else
            flash[:alert] = "Niet genoeg voorraad voor #{cart_item.product.name}."
            redirect_to cart_path(@current_cart) and return
          end
        end
    
        @purchased_cart = Cart.find_by_secret_id(params[:id])
        redirect_to root_path if !@purchased_cart
      end
    end
    
    

    private
    def set_product
        @product = Product.find(params[:product_id])
      end
end
