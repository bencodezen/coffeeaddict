class Location < ActiveRecord::Base
  require 'open-uri'
  require 'json'

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  def nearby_shops
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{self.latitude},#{self.longitude}&rankby=distance&keyword=coffee%20shops&key=#{api_key}"
    google_request = open(url).read
    initial_parse = JSON.parse google_request
    initial_parse["results"].first(10)
  end

  private

  def api_key
    "AIzaSyCQHFb2KhptVc4Lnqsj4jOu44wHv5zzlWY"
  end

end
