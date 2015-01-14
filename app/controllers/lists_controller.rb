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

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def map_view
    data = List.find(params[:id]).to_geojson_array
    @geojson = ActiveSupport::JSON.encode(data)
  end

  def map_create
    params["lists"].each_value do |list|
      @list = List.new
      @list.name = list["name"]
      if @list.save
        list["voter_ids"].each do |voter_id|
          ListMembership.create(voter_id: voter_id, list_id: @list.id)
        end
      else
        flash[:notice] = "#{@list.name} save failed"
        @errors = @list.errors.full_messages
      end
    end
    flash[:notice] = "Lists saved" unless flash[:notice]
    render js: "window.location = '#{lists_path}'"
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
