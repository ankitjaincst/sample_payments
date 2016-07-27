class OnlinePayment < ActiveRecord::Base
  belongs_to :booking_fare
  has_many :paytms
  has_many :citrus_gateways

  def get_total_amount
    payment_modes_used = self.payment_modes.split(',')
    total_amount = 0
    payment_modes_used.each do |payment_mode|
      if payment_mode == 'paytm'
        total_amount = total_amount + self.paytms.sum(:amount)
      end
      if payment_mode == 'citrus_gateway'
        total_amount = total_amount + self.citrus_gateways.sum(:amount)
      end
    end
    return total_amount
  end

  def save_online_payment_record(payment_mode,amount)
    payment_modes = self.payment_modes
    payment_modes_a = payment_modes.split(',')
    payment_modes_a << payment_mode
    payment_modes_a.uniq!
    self.payment_modes = payment_modes_a.join(',')
    if payment_mode == 'paytm'
      paytm = Paytm.create!(amount: amount)
      paytm.online_payment = self
      paytm.save!
    elsif payment_mode == 'citrus_gateway'
      citrus_gateway = CitrusGateway.create!(amount: amount)
      citrus_gateway.online_payment = self
      citrus_gateway.save!
    end
    self.save!
  end

end
