require 'bundler/setup'
Bundler.require

require 'open-uri'
require 'erb'
require 'time'
require 'json'

get '/' do
  @now = Time.now
  tries = 0
  begin
    tries += 1
    weather_json = open('http://api.openweathermap.org/data/2.5/weather?lat=36.008111&lon=-95.942436&units=imperial').read
    forecast_json = open('http://api.openweathermap.org/data/2.5/forecast/daily?lat=36.008111&lon=-95.942436&cnt=1&mode=json&units=imperial').read
  rescue
    sleep 5
    retry unless tries > 60 # 5 minutes
  end
  @weather = JSON.parse(weather_json)
  @forecast = JSON.parse(forecast_json)
  @sunrise = Time.at(@weather['sys']['sunrise'])
  @sunset = Time.at(@weather['sys']['sunset'])
  erb :home
end
