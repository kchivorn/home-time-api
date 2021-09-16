# HomeTime API For Receiving Payloads From Multiple Partners Using The Same Endpoint

## Introduction
Hometime integrates with multiple partners in our industry. Across these
partners, we typically receive the same data formatted in different ways. For
example, the reservation payload we receive from Airbnb, is different from the
reservation payload from Booking.com.

This API can parse and save 2 different payloads with 1 API endpoint.

**Local base URL:** http://localhost:3000

**Endpoint:** /api/v1/reservations

**Airbnb Payload:**
```
{
  "reservation_code": "YYY12345678",
  "start_date": "2021-04-14",
  "end_date": "2021-04-18",
  "nights": 4,
  "guests": 4,
  "adults": 2,
  "children": 2,
  "infants": 0,
  "status": "accepted",
  "guest": {
  "first_name": "Wayne",
  "last_name": "Woodbridge",
  "phone": "639123456789",
  "email": "wayne_woodbridge@bnb.com"
  },
  "currency": "AUD",
  "payout_price": "4200.00",
  "security_price": "500",
  "total_price": "4700.00"
}
```

**Booking.com Payload:**
```
{
  "reservation": {
    "code": "XXX12345678",
    "start_date": "2021-03-12",
    "end_date": "2021-03-16",
    "expected_payout_amount": "3800.00",
    "guest_details": {
      "localized_description": "4 guests",
      "number_of_adults": 2,
      "number_of_children": 2,
      "number_of_infants": 0
    },
    "guest_email": "wayne_woodbridge@bnb.com",
    "guest_first_name": "Wayne",
    "guest_last_name": "Woodbridge",
    "guest_phone_numbers": [
      "639123456789",
      "639123456789"
    ],
    "listing_security_price_accurate": "500.00",
    "host_currency": "AUD",
    "nights": 4,
    "number_of_guests": 4,
    "status_type": "accepted",
    "total_paid_amount_accurate": "4300.00"
  }
}
```

## How to run the project on local machine
1. Clone the repository: `git clone git@github.com:kchivorn/home-time-api.git`
2. Change directory to the project: `cd home-time-api`
3. Run `bundle install`
4. Start the server: `rails server`

## How to test api
1. After the server is running, we can use API testing tool such as Postman to test
2. Create a PUT request using URL http://localhost:3000/api/v1/reservations and above payloads to test 
![home_time_api_postman](https://user-images.githubusercontent.com/26404683/133672510-7926ccc1-47e6-4590-af1e-3162fb9aa5fd.PNG)

You should be able to create or update reservations from both Airbnb and Booking.com using the same endpoint.

## Code Design and Implementation
1. Readable and maintainable code: following convention on separating the different logics, and put them in their appropriate places.
2. Scalable code: easy to scale in the event a third payload is introduced.
3. Use of standard practices: error handling, tests, clear documentation.

## How integration test using rspec
1. run `rspec spec/requests/reservations_api.rb`
