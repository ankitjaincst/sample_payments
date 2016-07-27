class Paytm < ActiveRecord::Base

  belongs_to :online_payment
  before_create :generate_paytm_id

  def generate_paytm_id
    self.paytm_payment_id = loop do
      paytm_payment_id = "PAYTM#{Random.rand(Constant::PAYTM_ID_RANGE).to_s}"
      break paytm_payment_id unless Paytm.exists?(paytm_payment_id: paytm_payment_id)
    end
  end

end
