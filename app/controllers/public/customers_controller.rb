class Public::CustomersController < ApplicationController

  def show
    @nickname = current_user.nickname
  end

end
