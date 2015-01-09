class ListMembershipsController < ApplicationController
  def create
    list_membership = ListMembership.create(list_membership_params)
    flash[:notice] = "Voter added to #{list_membership.list.name}"
    redirect_to list_path(list_membership.list)
  end

  private

  def list_membership_params
    params.require(:list_membership).permit(:list_id, :voter_id)
  end
end
