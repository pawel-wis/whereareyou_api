# frozen_string_literal: true

# Locations controller class handles user's location requests
class LocationsController < ApplicationController
  before_action :authenticate_user!
  def update
    location = Location.create(location_params)
    location.user_id = current_user.id
    return update_not_auth if params[:id].to_i != current_user.id
    return update_success if location.save

    update_failed
  end

  private

  def location_params
    params[:location].permit(:longitude, :latitude)
  end

  def update_success
    render json: {
      message: 'Success location update'
    }, status: :ok
  end

  def update_failed
    render json: {
      message: "Can't update location"
    }, status: :unprocessable_entity
  end

  def update_not_auth
    render json: {
      message: 'You are not that user!'
    }, status: :unauthorized
  end
end
