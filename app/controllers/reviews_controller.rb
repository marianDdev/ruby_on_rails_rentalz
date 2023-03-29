class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy]

  def index
    q = request.query_parameters
    @reviews = Review.where(property_id: q[:property_id])
    @property = Property.find(q[:property_id])
  end

  def show
  end

  def new
    @review = Review.new
    q = request.query_parameters
    @booking = Booking.find(q[:booking_id])
    @property = @booking.property
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @booking = @review.property.bookings.where(guest_id: current_user.id).first
    @property = @booking.property

    respond_to do |format|
      if @review.save
        @booking.is_reviewed = true
        @booking.save

        format.html do
          redirect_to review_url(@review),
                      notice: 'Review was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html do
          redirect_to review_url(@review),
                      notice: 'Review was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy

    respond_to do |format|
      format.html do
        redirect_to reviews_url, notice: 'Review was successfully destroyed.'
      end
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :message, :property_id, :user_id)
  end

  def booking_id_condition
    ['booking_id = ?', params[:booking_id]] unless params[:booking_id].blank?
  end
end
