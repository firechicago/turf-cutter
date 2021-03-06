class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @search = Search.create!(search_params)
    @voters = @search.voters.page(params[:page]) || []
    case @search.num_voters
    when 0
      flash[:alert] = "No voters found"
    when 1
      flash[:success] = "1 voter found"
    else
      flash[:success] = "#{@search.num_voters} voters found"
    end
    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])
    @voters = @search.voters.page(params[:page])
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
