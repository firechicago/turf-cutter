class VotersController < ApplicationController
  def index
    @voters = Voter.all.page(params[:page])
  end

  def show
    @voter = Voter.find(params[:id])
    @list_membership = ListMembership.new
    @lists = []
    List.all.each { |list| @lists << [list.name, list.id] }
    @contacts = @voter.contacts
  end

  def new
    @voter = Voter.new
  end

  def create
    @voter = Voter.new(voter_params)
    if @voter.save
      @voter.geocode
      flash[:success] = "Voter Created"
      redirect_to voter_path(@voter)
    else
      flash[:alert] = "Error"
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
      flash[:success] = "Error"
      @errors = @voter.errors.full_messages
      render "/voters/edit"
    else
      flash[:alert] = "Voter Updated"
      redirect_to voter_path(@voter)
    end
  end

  def destroy
    Voter.find(params[:id]).destroy
    flash[:success] = "Voter deleted"
    redirect_to root_path
  end

  def import
    errors = Voter.import(params[:voters_csv])
    if errors.length == 0
      flash[:success] = "Voters successfully uploaded"
    else
      flash[:alert] = "There were errors reading lines:" + errors.to_s
    end
    @voters = Voter.all.page(params[:page])
    redirect_to voters_path
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
