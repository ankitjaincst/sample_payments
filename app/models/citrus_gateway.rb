class CitrusGateway < ActiveRecord::Base

  belongs_to :online_payment
  before_create :generate_citrus_id

  def generate_citrus_id
    self.cirtus_payment_id = loop do
      cirtus_payment_id = "CITRUS#{Random.rand(Constant::CITRUS_ID_RANGE).to_s}"
      break cirtus_payment_id unless CitrusGateway.exists?(cirtus_payment_id: cirtus_payment_id)
    end
  end

end
