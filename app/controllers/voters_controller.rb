class VotersController < ApplicationController
  def new
    @voter = Voter.new
  end

  def create
  end
end
