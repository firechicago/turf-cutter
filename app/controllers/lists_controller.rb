class ListsController < ApplicationController
  def create
    @list = List.new(list_params)
    @search = Search.find(params[:list][:search_id])
    if @list.save
      @list.add_voters(@search.voters)
      flash[:success] = "List saved"
      redirect_to list_path(@list)
    else
      flash[:alert] = "Save failed"
      @errors = @list.errors.full_messages
      @voters = @search.voters.page(params[:page])
      render "/searches/show"
    end
  end

  def index
    @lists = List.page params[:page]
  end

  def show
    @list = List.find(params[:id])
    @voters = @list.voters.page(params[:page])
  end

  def map_view
    data = List.find(params[:id]).turf_cutting_geojson
    @geojson = ActiveSupport::JSON.encode(data)
  end

  def contact_map
    data = List.find(params[:id]).contact_logging_geojson
    @contact = Contact.new
    @geojson = ActiveSupport::JSON.encode(data)
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
