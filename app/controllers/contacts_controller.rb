class ContactsController < ApplicationController
  def new
    @voter = Voter.find(params[:id])
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "Contact Logged"
      redirect_to voter_path(@contact.voter_id)
    else
      @voter = Voter.find(@contact.voter_id)
      flash[:alert] = "Save Failed"
      # binding.pry
      render "new"
    end
  end

  def show
  end

  private

  def contact_params
    params.require(:contact).permit(:user_id, :voter_id, :outcome, :support, :note)
  end
end
