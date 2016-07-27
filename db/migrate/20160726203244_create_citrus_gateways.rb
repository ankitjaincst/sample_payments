class CreateCitrusGateways < ActiveRecord::Migration
  def change
    create_table :citrus_gateways do |t|
      t.string :cirtus_payment_id
      t.belongs_to :online_payment
      t.float :amount, default: 0
      t.timestamps null: false
    end
  end
end
