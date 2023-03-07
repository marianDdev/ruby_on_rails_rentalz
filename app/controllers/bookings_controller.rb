class BookingsController < ApplicationController

    before_action :require_guest, only: [:new, :create, :edit, :update, :my_bookings]

    def index
        if current_user.owner?
            @bookings = current_user.owner_bookings
        elsif current_user.guest?
            @bookings = current_user.guest_bookings
        end
    end

    def show
         @booking = Booking.find(params[:id])
    end

    def new
        @booking = Booking.new
        q = request.query_parameters
        @property = Property.find(q[:id])
        @propertyId = @property[:id]
        @ownerId = @property.user[:id]
        @guest = current_user
    end

    def create
        @booking = Booking.new(booking_params)

        if @booking.save
            redirect_to @booking
        else
            render 'new'
        end    
    end

    private
        def booking_params
            params.require(:booking)
            .permit(:guest_id, :owner_id, :property_id, :start_at, :end_at, :guests_count, :status)
        end

end
