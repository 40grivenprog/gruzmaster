class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.members
  end
end
