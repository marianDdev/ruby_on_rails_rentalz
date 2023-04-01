class BookingsController < ApplicationController
  before_action :require_guest, only: %i[new create]
  before_action :require_owner, only: %i[approve edit_status decline]

  def index
    get_bookings_by_user_role(current_user)
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    q = request.query_parameters
    @property = Property.find(q[:id])
    @property_id = @property[:id]
    @owner_id = @property.user[:id]
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to @booking
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def edit_status
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to @booking
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_status
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to @booking
    else
      render :edit_status, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(
      :guest_id,
      :owner_id,
      :property_id,
      :start_at,
      :end_at,
      :guests_count,
      :status,
      :comment,
    )
  end

  private

  def get_bookings_by_user_role(current_user)
    @bookings =
      (
        if current_user.owner?
          current_user.owner_bookings.where(property_id_condition)
        else
          current_user.guest_bookings.where(property_id_condition)
        end
      )
    get_bookings_by_checkin(@bookings)
  end

  private

  def get_bookings_by_checkin(bookings)
    @today = Date.today
    @past_bookings = bookings.where('end_at < ?', @today)
    @future_bookings = bookings.where('start_at > ?', @today)
    @current_bookings =
      bookings.where('start_at <= ? and end_at > ?', @today, @today)
  end

  def property_id_condition
    ['property_id = ?', params[:property_id]] unless params[:property_id].blank?
  end
end
