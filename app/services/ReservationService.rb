class ReservationService
  class << self
    def create_or_update_reservation(reservation_params)
      reservation = Reservation.find_by_reservation_code(reservation_params[:reservation_code])
      if reservation
        reservation.update!(reservation_params)
      else
        reservation = Reservation.create!(reservation_params)
      end
      reservation
    end
  end
end
