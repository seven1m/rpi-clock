require 'bundler/setup'
Bundler.require

require 'open-uri'
require 'erb'
require 'time'
require 'json'

LAT = 36.008111
LON = -95.942436
UNITS = 'imperial'

get '/' do
  @now = Time.now
  tries = 0
  begin
    tries += 1
    weather_json = open("http://api.openweathermap.org/data/2.5/weather?lat=#{LAT}&lon=#{LON}&units=#{UNITS}").read
    forecast_json = open("http://api.openweathermap.org/data/2.5/forecast/daily?lat=#{LAT}&lon=#{LON}&cnt=1&mode=json&units=#{UNITS}").read
  rescue
    # sometimes the api returns bad data :-/
    sleep 5
    retry unless tries > 60 # 5 minutes
  end
  @weather = JSON.parse(weather_json)
  @forecast = JSON.parse(forecast_json)
  @sunrise = Time.at(@weather['sys']['sunrise'])
  @sunset = Time.at(@weather['sys']['sunset'])
  erb :home
end
