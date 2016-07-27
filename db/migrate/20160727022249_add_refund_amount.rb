class AddRefundAmount < ActiveRecord::Migration
  def change
    add_column :booking_fares ,:refunded_amount, :float , default: 0
  end
end
