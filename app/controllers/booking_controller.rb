class BookingController < ApplicationController


  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
    @booking_fare = BookingFare.new(booking_fee: Constant::BOOKING_FEE,
                                    security: Constant::SECURITY)
  end

  def create
    booking = Booking.new(booking_params.merge(status: 'confirmed'))
    booking_fare = BookingFare.new(booking_fare_params)
    initial_charge = booking_fare.initial_charge

    total_online_received_amount = 0.0
    if params[:online_payment].present?
      params[:online_payment].each do |key, payment_record|
        total_online_received_amount = total_online_received_amount + payment_record[:amount].to_f
      end
    end

    if total_online_received_amount < initial_charge
      render_error(401, "Please pay the minimum amount #{initial_charge}",
                   :unacceptable)
      return
    end

    booking.save!
    booking_fare.save!
    booking.booking_fare = booking_fare

    if params[:online_payment].present?
      online_payment = OnlinePayment.create!
      booking_fare.online_payment = online_payment
      params[:online_payment].each do |key, payment_record|
        online_payment.save_online_payment_record(payment_record[:payment_mode],
                                                  payment_record[:amount])
      end
    end
    booking_fare.calculate_fare
    booking_fare.save!

    redirect_to booking_index_path
  end

  def edit
    @booking = Booking.find_by(booking_id: params[:booking_id])
    @booking_fare = @booking.booking_fare
  end

  def update
    booking = Booking.find_by(booking_id: params[:booking_id])
    booking_fare = booking.booking_fare
    booking.assign_attributes(booking_params)
    booking_fare.assign_attributes(booking_fare_params)

    if ['open','confirmed','started'].include? booking.status
      initial_charge = booking_fare.initial_charge
      total_online_received_amount = booking_fare.online_payment_done_amount
      if params[:online_payment].present?
        params[:online_payment].each do |key, payment_record|
          total_online_received_amount = total_online_received_amount + payment_record[:amount].to_f
        end
      end
      if total_online_received_amount < initial_charge
        render_error(401, "Please pay the minimum amount #{initial_charge}",
                     :unacceptable)
        return
      end
    end

    booking.save!
    booking_fare.save!
    booking.booking_fare = booking_fare

    if params[:online_payment].present?
      online_payment = booking_fare.online_payment || OnlinePayment.create!
      params[:online_payment].each do |key, payment_record|
        online_payment.save_online_payment_record(payment_record[:payment_mode], payment_record[:amount])
      end
    end

    booking_fare.calculate_fare
    booking_fare.save!

    redirect_to booking_index_path
  end

  def booking_detail
    @booking = Booking.find_by(booking_id: params[:booking_id])
    @booking_fare = @booking.booking_fare
    online_payment = @booking_fare.online_payment

    if online_payment.present?
      online_payment.payment_modes.split(',').each do |payment_mode|
        if payment_mode == 'paytm'
        @paytm_payments = online_payment.paytms
        end
        if payment_mode == 'citrus_gateway'
          @citrus_payments = online_payment.citrus_gateways
        end
      end
    end
  end

  private

  def booking_params
    params
        .require(:booking)
        .permit(:customer_id,
                :booking_time
        )
  end

  def booking_fare_params
    params
        .require(:booking_fare)
        .permit(:booking_fee,
                :security,
                :cleaning_charge,
                :late_charge,
                :damage_fee,
                :other_charge,
                :final_settlement_paid_amount,
                :refunded_amount
        )
  end


  def render_error(error_code, error_message, status)
    respond_to { |format|
      format.json { render json: {status: error_code, error: error_message}, status: status }
      format.html { render json: {status: error_code, error: error_message}, status: status }
      format.js { render json: {status: error_code, error: error_message}, status: status }
    }
  end

end
