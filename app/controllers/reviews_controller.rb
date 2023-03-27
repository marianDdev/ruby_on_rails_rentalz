class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    q = request.query_parameters
    @reviews = Review.where('property_id': q[:id])
    @property = Property.find(q[:id])
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
    q = request.query_parameters
    @booking = Booking.find(q[:booking_id])
    @property_id = @booking.property.id
    @guest = current_user
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @booking = @review.property.bookings.where('guest_id': current_user.id).first

    respond_to do |format|
      if @review.save
        @booking.is_reviewed = true
        @booking.save

        format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:rating, :message, :property_id, :user_id)
    end

   private
        def booking_id_condition
            ['booking_id = ?', params[:booking_id]] unless params[:booking_id].blank?
        end
end
