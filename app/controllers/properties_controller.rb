class PropertiesController < ApplicationController

    def index
        @properties = Property.limit(10)
    end
end
