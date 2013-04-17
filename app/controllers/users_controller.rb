class UsersController < ApplicationController
  doorkeeper_for :show
  respond_to :json

  def show
    respond_with User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end


end