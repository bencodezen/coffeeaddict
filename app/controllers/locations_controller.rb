class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]

  def show
    require 'open-uri'
    require 'json'

    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@location.latitude},#{@location.longitude}&rankby=distance&keyword=coffee%20shops&key=#{api_key}"
    google_request = open(url).read
    initial_parse = JSON.parse google_request
    @nearby_shops = initial_parse["results"].first(10)
    @api_key = api_key
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:address, :latitude, :longitude)
    end

    def api_key
      "AIzaSyCQHFb2KhptVc4Lnqsj4jOu44wHv5zzlWY"
    end
end
