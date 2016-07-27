class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :booking_id
      t.datetime :booking_time, null: false
      t.references :customer, null: false
      t.integer :status , default: Booking.statuses[:open]
      t.timestamps null: false
    end
  end
end
