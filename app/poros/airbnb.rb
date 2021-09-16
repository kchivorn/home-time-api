class Airbnb
  def initialize(data)
    raise 'Reservation code cannot be nil' unless data[:reservation_code]

    @reservation_code = data[:reservation_code]
    @start_date = data[:start_date]
    @end_date = data[:end_date]
    @nights = data[:nights]
    @guests = data[:guests]
    @adults = data[:adults]
    @children = data[:children]
    @infants = data[:infants]
    @guest_localized_desc = nil
    @status = data[:status]
    @guest_email = data[:guest][:email]
    @guest_first_name = data[:guest][:first_name]
    @guest_last_name = data[:guest][:last_name]
    @guest_phone = data[:guest][:phone]
    @currency = data[:currency]
    @payout_price = data[:payout_price]
    @security_price = data[:security_price]
    @total_price = data[:total_price]
  end

  def to_h
    JSON.parse(to_json, symbolize_names: true)
  end
end
