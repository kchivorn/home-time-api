class GuestService
  class << self
    def create_or_update_guest(guest_params)
      guest = Guest.find_by_email(guest_params[:email])
      if guest
        guest.update(guest_params)
      else
        byebug
        Guest.create(guest_params)
      end
    end
  end
end
