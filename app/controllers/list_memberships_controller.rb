class ListMembershipsController < ApplicationController
  def create
    list_membership = ListMembership.create(list_membership_params)
    flash[:notice] = "Voter added to #{list_membership.list.name}"
    redirect_to list_path(list_membership.list)
  end

  def destroy
    list_membership = ListMembership.find(params[:id])
    list = list_membership.list
    list_membership.destroy
    flash[:notice] = "Voter removed"
    redirect_to list_path(list)
  end

  private

  def list_membership_params
    params.require(:list_membership).permit(:list_id, :voter_id)
  end
end
