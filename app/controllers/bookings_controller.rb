class BookingsController < ApplicationController
    def index
        if current_user.owner?
            @bookings = current_user.owner_bookings.where(property_id_condition)
            
        elsif current_user.guest?
            @bookings = current_user.guest_bookings.where(property_id_condition)
        end
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
        @guest = current_user
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

      def update
        @booking = Booking.find(params[:id])
        if @booking.update(booking_params)
            redirect_to @booking
        else
           render :edit
        end
    end

    def approve
        @booking = Booking.find(params[:id])
        @booking.update(status: "approved") 
        redirect_to @booking
    end

    def edit_status
         @booking = Booking.find(params[:id])
    end

    def decline
        @booking = Booking.find(params[:id])
        if @booking.update(booking_params)
            redirect_to @booking
        else
            render :edit_status
        end
    end

    private
        def booking_params
            params.require(:booking)
            .permit(:guest_id, :owner_id, :property_id, :start_at, :end_at, :guests_count, :status, :decline_reason)
        end

    private
        def property_id_condition
            ['property_id = ?', params[:property_id]] unless params[:property_id].blank?
        end

end
