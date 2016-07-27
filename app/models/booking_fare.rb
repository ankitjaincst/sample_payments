class BookingFare < ActiveRecord::Base
  belongs_to :booking
  has_one :online_payment



  def calculate_fare
    self.total_charge = self.booking_fee +
        self.cleaning_charge +
        self.late_charge +
        self.damage_fee +
        self.other_charge

    self.online_payment_done_amount = self.calculate_online_payment_done

    total_payments_done =
        self.online_payment_done_amount +
        self.final_settlement_paid_amount

    self.pending_amount = self.total_charge - total_payments_done + self.refunded_amount
  end

  def initial_charge
    return  ( self.booking_fee +
              self.security +
              self.cleaning_charge +
              self.late_charge +
              self.damage_fee +
              self.other_charge)
  end

  def calculate_online_payment_done
    total =  self.online_payment.present? ? self.online_payment.get_total_amount : 0
    return total
  end

end
