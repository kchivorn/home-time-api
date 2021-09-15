class Reservation < ApplicationRecord
  belongs_to :guest

  enum status: {
    rejected: 0,
    accepted: 1,
    pending: 2
  }
  validates :reservation_code, uniqueness: true, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :nights, presence: true
  validates :guests, presence: true
  validates :adults, presence: true
  validates :children, presence: true
  validates :infants, presence: true
  validates :status, presence: true
  validates :guest_id, presence: true
  validates :currency, presence: true
  validates :payout_price, presence: true
  validates :security_price, presence: true
  validates :total_price, presence: true
end
