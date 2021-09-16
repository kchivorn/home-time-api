require 'rails_helper'

RSpec.describe 'Reservations Api', type: :request do
  describe 'when it receives valid payload of new reservation from Airbnb' do
    let(:valid_payload) do
      {
        "reservation_code": 'YYY12345678',
        "start_date": '2021-04-14',
        "end_date": '2021-04-18',
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": 'accepted',
        "guest": {
          "first_name": 'Wayne',
          "last_name": 'Woodbridge',
          "phone": '639123456789',
          "email": 'wayne_woodbridge@bnb.com'
        },
        "currency": 'AUD',
        "payout_price": '4200.00',
        "security_price": '500',
        "total_price": '4700.00'
      }
    end

    let(:success_response) do
      { 'id' => 1, 'reservation_code' => 'YYY12345678', 'start_date' => '2021-04-14', 'end_date' => '2021-04-18', 'nights' => 4,
        'guests' => 4, 'adults' => 2, 'guest_localized_desc' => nil, 'children' => 2, 'infants' => 0, 'status' => 'accepted', 'guest_id' => 1, 'currency' => 'AUD', 'payout_price' => '4200.0', 'security_price' => '500.0', 'total_price' => '4700.0' }
    end
    before do
      put api_v1_reservations_path, params: valid_payload
    end
    it 'can create a new reservation successfully' do
      body = JSON.parse(response.body)
      body.delete('created_at')
      body.delete('updated_at')
      expect(body).to eq(success_response)
      expect(response.status).to eq(201)
    end
  end

  describe 'when it receives valid payload of new reservation from Booking.com' do
    let(:valid_payload) do
      {
        "reservation": {
          "code": 'XXX12345678',
          "start_date": '2021-03-12',
          "end_date": '2021-03-16',
          "expected_payout_amount": '3800.00',
          "guest_details": {
            "localized_description": '4 guests',
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
          },
          "guest_email": 'wayne_woodbridge@bnb.com',
          "guest_first_name": 'Wayne',
          "guest_last_name": 'Woodbridge',
          "guest_phone_numbers": %w[
            639123456789
            639123456789
          ],
          "listing_security_price_accurate": '500.00',
          "host_currency": 'AUD',
          "nights": 4,
          "number_of_guests": 4,
          "status_type": 'accepted',
          "total_paid_amount_accurate": '4300.00'
        }
      }
    end

    let(:success_response) do
      { 'id' => 2, 'reservation_code' => 'XXX12345678', 'start_date' => '2021-03-12', 'end_date' => '2021-03-16', 'nights' => 4,
        'guests' => 4, 'adults' => 2, 'guest_localized_desc' => '4 guests', 'children' => 2, 'infants' => 0, 'status' => 'accepted', 'guest_id' => 2, 'currency' => 'AUD', 'payout_price' => '3800.0', 'security_price' => '500.0', 'total_price' => '4300.0' }
    end
    before do
      put api_v1_reservations_path, params: valid_payload
    end
    it 'can create a new reservation successfully' do
      body = JSON.parse(response.body)
      body.delete('created_at')
      body.delete('updated_at')
      expect(body).to eq(success_response)
      expect(response.status).to eq(201)
    end
  end

  describe 'when it receives valid payload to update existing reservation from Airbnb' do
    let(:existing_reservation) do
      {
        "reservation_code": 'YYY12345678',
        "start_date": '2021-04-14',
        "end_date": '2021-04-18',
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": 'accepted',
        "guest_id": 3,
        "currency": 'AUD',
        "payout_price": '4200.00',
        "security_price": '500',
        "total_price": '4700.00'
      }
    end

    let(:existing_guest) do
      {
        "first_name": 'Wayne',
        "last_name": 'Woodbridge',
        "phone": '639123456789',
        "email": 'wayne_woodbridge@bnb.com'
      }
    end

    let(:updated_payload) do
      {
        "reservation_code": 'YYY12345678',
        "start_date": '2021-04-14',
        "end_date": '2021-04-18',
        "nights": 3,
        "guests": 3,
        "adults": 2,
        "children": 1,
        "infants": 0,
        "status": 'accepted',
        "guest": {
          "first_name": 'Wayne',
          "last_name": 'Woodbridge',
          "phone": '639123456789',
          "email": 'wayne_woodbridge@bnb.com'
        },
        "currency": 'AUD',
        "payout_price": '3200.00',
        "security_price": '400',
        "total_price": '3600.00'
      }
    end

    let(:success_response) do
      { 'id' => 3, 'reservation_code' => 'YYY12345678', 'start_date' => '2021-04-14', 'end_date' => '2021-04-18', 'nights' => 3,
        'guests' => 3, 'adults' => 2, 'guest_localized_desc' => nil, 'children' => 1, 'infants' => 0, 'status' => 'accepted', 'guest_id' => 3, 'currency' => 'AUD', 'payout_price' => '3200.0', 'security_price' => '400.0', 'total_price' => '3600.0' }
    end

    before do
      guest = Guest.create(existing_guest)
      existing_reservation[:guest_id] = guest.id
      Reservation.create(existing_reservation)
    end
    it 'can update an existing reservation successfully' do
      put api_v1_reservations_path, params: updated_payload
      body = JSON.parse(response.body)
      body.delete('created_at')
      body.delete('updated_at')
      expect(body).to eq(success_response)
      expect(response.status).to eq(200)
    end
  end

  describe 'when it receives valid payload to update existing reservation from Booking.com' do
    let(:existing_reservation) do
      {
        "reservation_code": 'XXX12345678',
        "start_date": '2021-04-14',
        "end_date": '2021-04-18',
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": 'accepted',
        "guest_id": 3,
        "currency": 'AUD',
        "payout_price": '4200.00',
        "security_price": '500',
        "total_price": '4700.00'
      }
    end

    let(:existing_guest) do
      {
        "first_name": 'Wayne',
        "last_name": 'Woodbridge',
        "phone": %w[
          639123456789
          639123456788
        ],
        "email": 'wayne_woodbridge@bnb.com'
      }
    end

    let(:updated_payload) do
      {
        "reservation": {
          "code": 'XXX12345678',
          "start_date": '2021-03-12',
          "end_date": '2021-03-16',
          "expected_payout_amount": '3200.00',
          "guest_details": {
            "localized_description": '3 guests',
            "number_of_adults": 2,
            "number_of_children": 1,
            "number_of_infants": 0
          },
          "guest_email": 'wayne_woodbridge@bnb.com',
          "guest_first_name": 'Wayne',
          "guest_last_name": 'Woodbridge',
          "guest_phone_numbers": %w[
            639123456789
            639123456788
          ],
          "listing_security_price_accurate": '400.00',
          "host_currency": 'AUD',
          "nights": 3,
          "number_of_guests": 3,
          "status_type": 'accepted',
          "total_paid_amount_accurate": '3600.00'
        }
      }
    end

    let(:success_response) do
      { 'id' => 4, 'reservation_code' => 'XXX12345678', 'start_date' => '2021-03-12', 'end_date' => '2021-03-16', 'nights' => 3,
        'guests' => 3, 'adults' => 2, 'guest_localized_desc' => '3 guests', 'children' => 1, 'infants' => 0, 'status' => 'accepted', 'guest_id' => 4, 'currency' => 'AUD', 'payout_price' => '3200.0', 'security_price' => '400.0', 'total_price' => '3600.0' }
    end

    before do
      guest = Guest.create(existing_guest)
      existing_reservation[:guest_id] = guest.id
      Reservation.create(existing_reservation)
      put api_v1_reservations_path, params: updated_payload
    end
    it 'can update an existing reservation successfully' do
      body = JSON.parse(response.body)
      body.delete('created_at')
      body.delete('updated_at')
      expect(body).to eq(success_response)
      expect(response.status).to eq(200)
    end
  end

  describe 'when it receives valid payload to update existing reservation from Airbnb' do
    let(:existing_reservation) do
      {
        "reservation_code": 'YYY12345678',
        "start_date": '2021-04-14',
        "end_date": '2021-04-18',
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": 'accepted',
        "guest_id": 3,
        "currency": 'AUD',
        "payout_price": '4200.00',
        "security_price": '500',
        "total_price": '4700.00'
      }
    end

    let(:existing_guest) do
      {
        "first_name": 'Wayne',
        "last_name": 'Woodbridge',
        "phone": '639123456789',
        "email": 'wayne_woodbridge@bnb.com'
      }
    end

    let(:updated_payload) do
      {
        "reservation_code": 'YYY12345678',
        "start_date": '2021-04-14',
        "end_date": '2021-04-18',
        "nights": 3,
        "guests": 3,
        "adults": 2,
        "children": 1,
        "infants": 0,
        "status": 'accepted',
        "guest": {
          "first_name": 'boo',
          "last_name": 'bar',
          "phone": '639123456710',
          "email": 'boo_bar@bnb.com'
        },
        "currency": 'AUD',
        "payout_price": '3200.00',
        "security_price": '400',
        "total_price": '3600.00'
      }
    end

    let(:success_response) do
      { 'id' => 5, 'reservation_code' => 'YYY12345678', 'start_date' => '2021-04-14', 'end_date' => '2021-04-18', 'nights' => 3,
        'guests' => 3, 'adults' => 2, 'guest_localized_desc' => nil, 'children' => 1, 'infants' => 0, 'status' => 'accepted', 'guest_id' => 5, 'currency' => 'AUD', 'payout_price' => '3200.0', 'security_price' => '400.0', 'total_price' => '3600.0' }
    end

    context 'and user has updated his email and other infos during the reservation' do
      before do
        guest = Guest.create(existing_guest)
        existing_reservation[:guest_id] = guest.id
        Reservation.create(existing_reservation)
        put api_v1_reservations_path, params: updated_payload
      end
      it 'can update an existing reservation successfully' do
        body = JSON.parse(response.body)
        body.delete('created_at')
        body.delete('updated_at')
        expect(body).to eq(success_response)
        expect(response.status).to eq(200)
      end

      it 'update the email of the guest at the same time' do
        body = JSON.parse(response.body)
        guest = Guest.find_by_id(body['guest_id'])
        expect(guest.email).to eq('boo_bar@bnb.com')
        expect(guest.first_name).to eq('boo')
        expect(guest.last_name).to eq('bar')
        expect(guest.phone).to eq(%w[
                                    639123456710
                                  ])
      end
    end
  end

  describe 'when it receives valid payload to update existing reservation from Booking.com' do
    let(:existing_reservation) do
      {
        "reservation_code": 'XXX12345678',
        "start_date": '2021-04-14',
        "end_date": '2021-04-18',
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": 'accepted',
        "guest_id": 5,
        "currency": 'AUD',
        "payout_price": '4200.00',
        "security_price": '500',
        "total_price": '4700.00'
      }
    end

    let(:existing_guest) do
      {
        "first_name": 'Wayne',
        "last_name": 'Woodbridge',
        "phone": %w[
          639123456789
          639123456788
        ],
        "email": 'wayne_woodbridge@bnb.com'
      }
    end

    let(:updated_payload) do
      {
        "reservation": {
          "code": 'XXX12345678',
          "start_date": '2021-03-12',
          "end_date": '2021-03-16',
          "expected_payout_amount": '3200.00',
          "guest_details": {
            "localized_description": '3 guests',
            "number_of_adults": 2,
            "number_of_children": 1,
            "number_of_infants": 0
          },
          "guest_email": 'woodbridge@bnb.com',
          "guest_first_name": 'boo',
          "guest_last_name": 'bar',
          "guest_phone_numbers": %w[
            639123456710
            639123456711
          ],
          "listing_security_price_accurate": '400.00',
          "host_currency": 'AUD',
          "nights": 3,
          "number_of_guests": 3,
          "status_type": 'accepted',
          "total_paid_amount_accurate": '3600.00'
        }
      }
    end

    let(:success_response) do
      { 'id' => 7, 'reservation_code' => 'XXX12345678', 'start_date' => '2021-03-12', 'end_date' => '2021-03-16', 'nights' => 3,
        'guests' => 3, 'adults' => 2, 'guest_localized_desc' => '3 guests', 'children' => 1, 'infants' => 0, 'status' => 'accepted', 'guest_id' => 7, 'currency' => 'AUD', 'payout_price' => '3200.0', 'security_price' => '400.0', 'total_price' => '3600.0' }
    end

    context 'and user has updated his email and other infos during the reservation' do
      before do
        guest = Guest.create(existing_guest)
        existing_reservation[:guest_id] = guest.id
        Reservation.create(existing_reservation)
        put api_v1_reservations_path, params: updated_payload
      end
      it 'can update an existing reservation successfully' do
        body = JSON.parse(response.body)
        body.delete('created_at')
        body.delete('updated_at')
        expect(body).to eq(success_response)
        expect(response.status).to eq(200)
      end

      it 'update the email of the guest at the same time' do
        body = JSON.parse(response.body)
        guest = Guest.find_by_id(body['guest_id'])
        expect(guest.email).to eq('woodbridge@bnb.com')
        expect(guest.first_name).to eq('boo')
        expect(guest.last_name).to eq('bar')
        expect(guest.phone).to eq(%w[
                                    639123456710
                                    639123456711
                                  ])
      end
    end
  end

  describe 'when it receives invalid payload of new reservation from Airbnb' do
    let(:invalid_payload) do
      {
        "reservation_code": 'YYY12345678',
        "guest": {
          "first_name": 'Wayne',
          "last_name": 'Woodbridge',
          "phone": '639123456789',
          "email": 'wayne_woodbridge@bnb.com'
        }
      }
    end

    let(:failed_response) do
      ["Start date can't be blank",
       "End date can't be blank",
       "Nights can't be blank",
       "Guests can't be blank",
       "Adults can't be blank",
       "Children can't be blank",
       "Infants can't be blank",
       "Status can't be blank",
       "Currency can't be blank",
       "Payout price can't be blank",
       "Security price can't be blank",
       "Total price can't be blank"]
    end
    before do
      put api_v1_reservations_path, params: invalid_payload
    end
    it 'will show correct error message' do
      expect(response.body).to eq('Validation failed: ' + failed_response.join(', '))
      expect(response.status).to eq(422)
    end
  end

  describe 'when it receives invalid payload from Airbnb without guest info' do
    let(:invalid_payload) do
      {
        "reservation_code": 'YYY12345678'
      }
    end

    before do
      put api_v1_reservations_path, params: invalid_payload
    end
    it 'will show correct error message' do
      expect(response.body).to eq('Guest cannot be empty')
      expect(response.status).to eq(422)
    end
  end

  describe 'when it receives empty payload of new reservation from Airbnb or Booking.com' do
    let(:invalid_payload) do
      {}
    end

    before do
      put api_v1_reservations_path, params: invalid_payload
    end
    it 'will show correct error message' do
      expect(response.body).to eq('Reservation code cannot be empty')
      expect(response.status).to eq(422)
    end
  end

  describe 'when it receives invalid payload of new reservation from Booking.com' do
    let(:invalid_payload) do
      {
        "reservation": {
          "code": 'XXX12345678',
          "guest_details": {
            "localized_description": '4 guests'
          },
          "guest_email": 'wayne_woodbridge@bnb.com',
          "guest_first_name": 'Wayne',
          "guest_last_name": 'Woodbridge',
          "guest_phone_numbers": %w[
            639123456789
            639123456789
          ]
        }
      }
    end

    let(:failed_response) do
      ["Start date can't be blank",
       "End date can't be blank",
       "Nights can't be blank",
       "Guests can't be blank",
       "Adults can't be blank",
       "Children can't be blank",
       "Infants can't be blank",
       "Status can't be blank",
       "Currency can't be blank",
       "Payout price can't be blank",
       "Security price can't be blank",
       "Total price can't be blank"]
    end

    before do
      put api_v1_reservations_path, params: invalid_payload
    end

    it 'will show correct error message' do
      expect(response.body).to eq('Validation failed: ' + failed_response.join(', '))
      expect(response.status).to eq(422)
    end
  end

  describe 'when it receives invalid payload without guest email from Booking.com' do
    let(:invalid_payload) do
      {
        "reservation": {
          "code": 'XXX12345678',
          "guest_details": {
            "localized_description": '4 guests'
          },

          "guest_first_name": 'Wayne',
          "guest_last_name": 'Woodbridge',
          "guest_phone_numbers": %w[
            639123456789
            639123456789
          ]
        }
      }
    end

    before do
      put api_v1_reservations_path, params: invalid_payload
    end

    it 'will show correct error message' do
      expect(response.body).to eq("Validation failed: Email can't be blank")
      expect(response.status).to eq(422)
    end
  end

  describe 'when it receives invalid payload without guest phone numbers from Booking.com' do
    let(:invalid_payload) do
      {
        "reservation": {
          "code": 'XXX12345678',
          "start_date": '2021-03-12',
          "end_date": '2021-03-16',
          "expected_payout_amount": '3800.00',
          "guest_details": {
            "localized_description": '4 guests',
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
          },
          "guest_email": 'wayn_woodbridge@bnb.com',
          "guest_first_name": 'Wayne',
          "guest_last_name": 'Woodbridge',

          "listing_security_price_accurate": '500.00',
          "host_currency": 'AUD',
          "nights": 4,
          "number_of_guests": 4,
          "status_type": 'accepted',
          "total_paid_amount_accurate": '4300.00'
        }
      }
    end

    before do
      put api_v1_reservations_path, params: invalid_payload
    end

    it 'will show correct error message' do
      expect(response.body).to eq('Guest phone numbers cannot be empty')
      expect(response.status).to eq(422)
    end
  end

  describe 'when it receives invalid payload without guest details from Booking.com' do
    let(:invalid_payload) do
      {
        "reservation": {
          "code": 'XXX12345678',
          "start_date": '2021-03-12',
          "end_date": '2021-03-16',
          "expected_payout_amount": '3800.00',
          "guest_details": {
          },
          "guest_email": 'wayn_woodbridge@bnb.com',
          "guest_first_name": 'Wayne',
          "guest_last_name": 'Woodbridge',

          "listing_security_price_accurate": '500.00',
          "host_currency": 'AUD',
          "nights": 4,
          "number_of_guests": 4,
          "status_type": 'accepted',
          "total_paid_amount_accurate": '4300.00'
        }
      }
    end

    before do
      put api_v1_reservations_path, params: invalid_payload
    end

    it 'will show correct error message' do
      expect(response.body).to eq('Guest Details cannot be empty')
      expect(response.status).to eq(422)
    end
  end
end
