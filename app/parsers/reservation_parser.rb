class ReservationParser
  class << self
    def parse(data)
      Airbnb.new(data).to_h
    rescue ExceptionHandler::MissingReservationCode
      BookingDotCom.new(data).to_h
    end
  end
end
