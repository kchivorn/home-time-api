module ExceptionHandler
  extend ActiveSupport::Concern

  class MissingGuest < StandardError; end

  class MissingReservationCode < StandardError; end

  class MissingGuestPhoneNumbers < StandardError; end

  class MissingGuestDetails < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::MissingGuest, with: :four_twenty_two
    rescue_from ExceptionHandler::MissingReservationCode, with: :four_twenty_two
    rescue_from ExceptionHandler::MissingGuestPhoneNumbers, with: :four_twenty_two
    rescue_from ExceptionHandler::MissingGuestDetails, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end

  private

  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end
end
