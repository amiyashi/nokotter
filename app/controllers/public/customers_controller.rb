class Public::CustomersController < ApplicationController
  
  def new
    @customer = Customer.new
  end

  def show
    @customer = current_customer
  end

end
