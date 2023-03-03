class PropertiesController < ApplicationController

    before_action :require_owner, only: [:new, :create]

    def index
        @properties = Property.all.order(created_at: :desc)
    end

    def show
        @property = Property.find(params[:id])
    end

    def new
        @property = Property.new
    end

    def create
        property_params[:user_id] = current_user.id
        property_params[:is_available] = true

        @property = Property.new(property_params)

        if @property.save
            redirect_to '/'
        else
            redirect_to '/properties/new'    
        end
    end

    def edit
        @property = Property.find(params[:id])
    end
    
    def update
        @property = Property.find(params[:id])
        if @property.update(property_params)
            redirect_to @property
        else
            render 'edit'
        end
    end

    private
        def property_params
            params.require(:property).permit(
                :user_id,
                :category,
                :continent,
                :country,
                :city,
                :neighbourhood,
                :name,
                :description,
                :facilities,
                :rating,
                :reviews,
                :guests,
                :bedrooms,
                :beds,
                :baths,
                :price,
                :currency,
                :is_available,
            )
        end   

end
