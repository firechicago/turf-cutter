class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @search = Search.create!(search_params)
    case @search.num_voters
    when 0
      flash[:notice] = "No voters found"
    when 1
      flash[:notice] = "1 voter found"
    else
      flash[:notice] = "#{@search.voters.length} voters found"
    end
    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])
    @list = List.new
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
