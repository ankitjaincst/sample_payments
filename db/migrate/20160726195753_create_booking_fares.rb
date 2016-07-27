class CreateBookingFares < ActiveRecord::Migration
  def change
    create_table :booking_fares do |t|
      t.references :booking
      t.float :booking_fee , default: 0
      t.float :security , default: 0
      t.float :cleaning_charge, default: 0
      t.float :late_charge, default: 0
      t.float :damage_fee, default: 0
      t.float :other_charge, default: 0
      t.float :total_charge, default: 0
      t.float :pending_amount, default: 0
      t.float :online_payment_done_amount, default: 0
      t.float :final_settlement_paid_amount, default: 0
      t.timestamps null: false
    end
  end
end
