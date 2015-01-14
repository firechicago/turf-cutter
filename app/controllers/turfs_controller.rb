class TurfsController < ApplicationController
  def create
    unless current_user
      flash[:notice] = "You must be signed in to do that."
      render "/"
      return
    end
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
end
