require "http"
require "json"

puts "What is your location?"

location = gets

puts "Checking the weather at #{location}"

gmaps_response = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV.fetch("GMAPS_KEY")}")

gmaps_parse = JSON.parse(gmaps_response)

gmaps_results_array = gmaps_parse.fetch("results")

gmaps_results_obj = gmaps_results_array.at(0)

gmaps_geometry = gmaps_results_obj.fetch("geometry")

gmaps_location = gmaps_geometry.fetch("location")

lat = gmaps_location.fetch("lat")

lng = gmaps_location.fetch("lng")

puts "Your coordinates are #{lat}, #{lng}"

weather_response = HTTP.get("https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{lat},#{lng}")

weather_parse = JSON.parse(weather_response)

currently = weather_parse.fetch("currently")

current_temp = currently.fetch("temperature")

current_summary = currently.fetch("summary")

puts "It is currently #{current_temp}°F."

puts "Next hour: #{current_summary}"
