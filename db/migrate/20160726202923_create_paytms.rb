class CreatePaytms < ActiveRecord::Migration
  def change
    create_table :paytms do |t|
      t.string :paytm_payment_id
      t.belongs_to :online_payment
      t.float :amount, default: 0
      t.timestamps null: false
    end
  end
end
