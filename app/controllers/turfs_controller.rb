class TurfsController < ApplicationController
  before_action :require_login

  def create
    unless valid_params?(params)
      render js: "alert('Save Failed')"
      return
    end
    if Turf.create(params)
      flash[:success] = "Lists saved"
      render js: "window.location = '#{lists_path}'"
    else
      render js: "alert('Save Failed')"
    end
  end

  private

  def require_login
    unless current_user
      flash[:alert] = "You must be signed in to do that"
      redirect_to root_path
    end
  end

  def valid_params?(params)
    return false if params["lists"].nil?
    params["lists"].values.each do |list|
      return false unless list["voter_ids"].class == Array
    end
    true
  end
end
