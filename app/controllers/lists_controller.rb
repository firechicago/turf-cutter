class ListsController < ApplicationController
  def create
    @list = List.new(list_params)
    @search = Search.find(params[:list][:search_id])
    if @list.save
      @search.voters.each do |voter|
        ListMembership.create(voter_id: voter.id, list_id: @list.id)
      end
      flash[:notice] = "List saved"
      redirect_to list_path(@list)
    else
      flash[:notice] = "Save failed"
      @errors = @list.errors.full_messages
      render "/searches/show"
    end
  end

  def show
    @list = List.find(params[:id])
  end

  def map_view
    data = List.find(params[:id]).to_geojson_array
    @geojson = ActiveSupport::JSON.encode(data)
  end

  def map_create
    # binding.pry
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
