class Booking < ActiveRecord::Base

  before_create :generate_booking_id

  belongs_to :customer
  has_one :booking_fare

  enum status: [:open, :confirmed, :cancelled, :started, :completed]


  def generate_booking_id
    self.booking_id = loop do
      booking_id = "ZOOM#{Random.rand(Constant::BOOOKING_ID_RANGE).to_s}"
      break booking_id unless Booking.exists?(booking_id: booking_id)
    end
  end



end
