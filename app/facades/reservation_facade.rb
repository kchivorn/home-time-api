class ReservationFacade
  class << self
    def create_reservation(payload)
      reservation_hash = ReservationParser.parse(payload)
      ReservationService.create_or_update_reservation(reservation_hash)
    end
  end
end
