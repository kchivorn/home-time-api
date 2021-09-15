class BookingDotCom
  def initialize(data)
    reservation = data[:reservation]
    @reservation_code = reservation[:code]
    @start_date = reservation[:start_date]
    @end_date = reservation[:end_date]
    @nights = reservation[:nights]
    @guests = reservation[:number_of_guests]
    guest_details = reservation[:guest_details]
    @adults = guest_details[:number_of_adults]
    @children = guest_details[:number_of_children]
    @infants = guest_details[:number_of_infants]
    @guest_localized_desc = guest_details[:localized_description]
    @status = data[:status_type]
    @guest_email = reservation[:guest_email]
    @guest_first_name = reservation[:guest_first_name]
    @guest_last_name = reservation[:guest_last_name]
    @guest_phone = reservation[:guest_phone_numbers]
    @currency = reservation[:host_currency]
    @payout_price = reservation[:expected_payout_amount]
    @security_price = reservation[:listing_security_price_accurate]
    @total_price = reservation[:total_paid_amount_accurate]
  end

  def to_h
    JSON.parse(to_json, symbolize_names: true)
  end
end
