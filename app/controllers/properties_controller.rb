class PropertiesController < ApplicationController

    before_action :require_owner, only: [:new, :create, :my_properties]

    def index
        @q = Property.ransack(params[:q])
        @properties = @q.result(distinct: true)
    end

    def my_properties
        @properties = current_user.properties.order(created_at: :desc)
    end

    def show
        @property = Property.find(params[:id])
    end

    def new
        @property = Property.new
    end

    def create
        @property = Property.new(property_params)
        @property.images.attach(params[:property][:images])

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

    def destroy
        @property = Property.find(params[:id])
        @property.destroy
        flash[:success] = "The property was successfully destroyed."
        redirect_to root_url
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
                :images
            ).merge(user: current_user, is_available: true)
        end   

end
