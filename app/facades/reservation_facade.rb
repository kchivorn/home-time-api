class ReservationFacade
  class << self
    def create_reservation(payload)
      reservation_hash = ReservationParser.parse(payload)
      guest_params = guest_params(reservation_hash)
      guest = GuestService.create_or_update_guest(guest_params)
      reservation_params = reservation_params(reservation_hash)
      reservation = ReservationService.create_or_update_reservation(reservation_hash.merge(guest_id: 1))
    end

    private

    def guest_params(reservation_hash)
      {
        email: reservation_hash[:guest_email],
        first_name: reservation_hash[:first_name],
        last_name: reservation_hash[:last_name],
        phone: reservation_hash[:guest_phone]
      }
    end

    def reservation_params(reservation_hash)
      reservation_hash.delete(:guest_email)
      reservation_hash.delete(:guest_first_name)
      reservation_hash.delete(:guest_last_name)
      reservation_hash.delete(:guest_phone)
      reservation_hash
    end
  end
end
