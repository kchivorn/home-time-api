class ReservationParser
  class << self
    def parse(data)
      Airbnb.new(data).to_h
    rescue StandardError
      BookingDotCom.new(data).to_h
    end
  end
end
