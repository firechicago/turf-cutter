class VotersController < ApplicationController
  def show
    @voter = Voter.find(params[:id])
    @list_membership = ListMembership.new
    @lists = []
    List.all.each { |list| @lists << [list.name, list.id] }
  end

  def new
    @voter = Voter.new
  end

  def create
    @voter = Voter.new(voter_params)
    @voter.geocode
    if @voter.save
      flash[:notice] = "Voter Created"
      redirect_to voter_path(@voter)
    else
      flash[:notice] = "Error"
      @errors = @voter.errors.full_messages
      render "/voters/new"
    end
  end

  def edit
    @voter = Voter.find(params[:id])
  end

  def update
    @voter = Voter.update(params[:id], voter_params)
    if @voter.errors.any?
      flash[:notice] = "Error"
      @errors = @voter.errors.full_messages
      render "/voters/edit"
    else
      flash[:notice] = "Voter Updated"
      redirect_to voter_path(@voter)
    end
  end

  def destroy
    Voter.find(params[:id]).destroy
    flash[:notice] = "Voter deleted"
    redirect_to root_path
  end

  private

  def voter_params
    params.require(:voter).permit(
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
