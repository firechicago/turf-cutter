class ListsController < ApplicationController
  def create
    @list = List.new(list_params)
    search = Search.find(params[:list][:search_id])
    if @list.save
      search.voters.each do |voter|
        ListMembership.create(voter_id: voter.id, list_id: @list.id)
      end
      flash[:notice] = "List saved"
      redirect_to list_path(@list)
    else
      flash[:notice] = "Error"
      @errors = @voter.errors.full_messages
      render "search#show"
    end
  end

  def show
    @list = List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
