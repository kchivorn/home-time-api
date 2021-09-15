class ReservationParser
  class << self
    def parse(data)
      # byebug
      # parsed_data = JSON.parse(data.to_json, symbolize_names: true)
      Airbnb.new(data).to_h
    rescue StandardError
      BookingDotCom.new(data).to_h
    end
  end
end
