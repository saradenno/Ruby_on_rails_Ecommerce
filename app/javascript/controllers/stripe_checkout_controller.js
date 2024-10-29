import { Controller } from "@hotwired/stimulus"
import {post} from "@rails/request.js"



// Connects to data-controller="stripe-checkout"
export default class extends Controller {
  static values = { url: String }


  async connect() {
    let publicKey = document.head.querySelector('meta[name="stripe-pk"]').content
    const stripe = Stripe(publicKey)
   
    const fetchClientSecret = async () => {
      //using request.js to make fetch request
      const response = await post(this.urlValue);
      const { clientSecret } = await response.json;
      return clientSecret;
    };
    
    const checkout = await stripe.initEmbeddedCheckout({
      fetchClientSecret,
    });
    
      // Mount Checkout
    checkout.mount(this.element);
  }
 
}

