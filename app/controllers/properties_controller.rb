class PropertiesController < ApplicationController
  before_action :require_owner, only: %i[new create my_properties]
  before_action :set_countries, only: %i[new create]
  before_action :set_cities, only: %i[new create]

  def index
    @q = Property.ransack(params[:q])
    @pagy, @properties =
      pagy(@q.result(distinct: true).order(created_at: :desc), items: 20)
  end

  def my_properties
    @pagy, @properties = pagy(current_user.properties.order(created_at: :desc))
  end

  def show
    @property = Property.find(params[:id])
  end

  def new
    @property = Property.new
    @countries = Country.pluck(:name)
    @cities = City.pluck(:name)
  end

  def create
    @property = Property.create(property_params)
    @property.images.attach(params[:property][:images])

    if @property.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @property = Property.find(params[:id])
    @countries = Country.pluck(:name)
    @cities = City.pluck(:name)
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
    flash[:success] = 'The property was successfully destroyed.'
    redirect_to root_url
  end

  private

  def property_params
    params
      .require(:property)
      .permit(
        :user_id,
        :category,
        :country,
        :city,
        :neighbourhood,
        :name,
        :description,
        :facilities,
        :guests,
        :bedrooms,
        :beds,
        :baths,
        :price,
        :currency,
        :images,
      )
      .merge(user: current_user, is_available: true)
  end

  def set_countries
    @countries = Country.pluck(:name)
  end

  def set_cities
    @cities = City.pluck(:name)
  end
end
