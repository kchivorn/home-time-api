class ReservationService
  class << self
    def create_or_update_reservation(reservation_hash)
      reservation_params = reservation_params(reservation_hash)
      reservation = Reservation.find_by_reservation_code(reservation_params[:reservation_code])
      guest_params = guest_params(reservation_hash)
      if reservation
        reservation.update!(reservation_params)
        GuestService.update_guest(guest_params.merge(id: reservation.guest_id))
        { data: reservation, status: 200 }
      else
        guest = GuestService.create_or_update_guest(guest_params)
        reservation = Reservation.create!(reservation_params.merge(guest_id: guest.id))
        { data: reservation, status: 201 }
      end
    end

    private

    def guest_params(reservation_hash)
      {
        id: reservation_hash[:guest_id],
        email: reservation_hash[:guest_email],
        first_name: reservation_hash[:guest_first_name],
        last_name: reservation_hash[:guest_last_name],
        phone: reservation_hash[:guest_phone]
      }
    end

    def reservation_params(reservation_hash)
      {
        reservation_code: reservation_hash[:reservation_code],
        start_date: reservation_hash[:start_date],
        end_date: reservation_hash[:end_date],
        nights: reservation_hash[:nights],
        guests: reservation_hash[:guests],
        adults: reservation_hash[:adults],
        children: reservation_hash[:children],
        infants: reservation_hash[:infants],
        guest_localized_desc: reservation_hash[:guest_localized_desc],
        status: reservation_hash[:status],
        currency: reservation_hash[:currency],
        payout_price: reservation_hash[:payout_price],
        security_price: reservation_hash[:security_price],
        total_price: reservation_hash[:total_price]
      }
    end
  end
end
