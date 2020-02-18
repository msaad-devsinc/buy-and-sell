class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    render json: params
  end
  def about
  end

  def contact
  end
end
