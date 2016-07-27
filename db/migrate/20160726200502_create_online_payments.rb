class CreateOnlinePayments < ActiveRecord::Migration
  def change
    create_table :online_payments do |t|
      t.references :booking_fare
      t.string :payment_modes, default: ''
      t.timestamps null: false
    end
  end
end
