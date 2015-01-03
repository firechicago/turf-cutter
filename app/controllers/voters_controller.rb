class VotersController < ApplicationController
  def show
    @voter = Voter.find(params[:id])
  end

  def new
    @voter = Voter.new
  end

  def create
    @voter = Voter.new(voter_params)
    if @voter.save
      flash[:notice] = "Voter Created"
      redirect_to voter_path(@voter)
    else
      flash[:notice] = "Error"
      @errors = voter.errors.full_messages
      render "voter#new"
    end
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
