class Api::V1::ReservationsController < ApplicationController
  def update
    response = ReservationFacade.create_reservation(params)
    render json: response[:data], status: response[:status]
  rescue StandardError => e
    render json: e.message, status: :unprocessable_entity
  end
end
