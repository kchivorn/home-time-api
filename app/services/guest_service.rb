class GuestService
  class << self
    def create_or_update_guest(guest_params)
      guest = Guest.find_by_email(guest_params[:email])
      if guest
        guest.update!(guest_params.merge(id: guest.id))
      else
        guest = Guest.create!(guest_params)
      end
      guest
    end

    def update_guest(guest_params)
      guest = Guest.find_by_id(guest_params[:id])
      guest.update!(guest_params) if guest && guest.email != guest_params[:email]
    end
  end
end
