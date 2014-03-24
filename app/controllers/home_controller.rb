class HomeController < ApplicationController
  def index
    redirect_to '/users/sign_in' unless signed_in?
  end
end
