class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
  end

  def show
  end

  private

  def search_params
    params.require(:search).permit(
    :first_name,
    :last_name,
    :address1,
    :address2,
    :city,
    :state,
    :zip
    )
  end
end
