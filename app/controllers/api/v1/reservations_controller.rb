class Api::V1::ReservationsController < ApplicationController
  def update
    @reservation = ReservationFacade.create_reservation(params)
    render json: @reservation
  rescue StandardError => e
    render json: e.message, status: :unprocessable_entity
  end
end
