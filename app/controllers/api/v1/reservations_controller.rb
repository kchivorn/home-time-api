class Api::V1::ReservationsController < ApplicationController
  def update
    @reservation = ReservationFacade.create_reservation(params)
    render json: @reservation
  end
end
