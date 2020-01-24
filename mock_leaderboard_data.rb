#!/usr/bin/env ruby

require 'net/http'
require 'open-uri'
require 'json'

# URL that the leaderboard score is posted to as a JSON post within the http body
LISTENER = "http://localhost:3000/receiver/leaderboard/FT7E3Y68UPA6"

# Holds state of the leaderboard
$state = [
  { driver_name: "Newgarden", country: "US", car_number: 2, car_colour: "#D80212",
    position: 1, interval: 0, pitting: false, last_lap: 0 },
  { driver_name: "Pagenaud", country: "FR", car_number: 12, car_colour: "#4D4D4D",
    position: 2, interval: 0, pitting: false, last_lap: 0 },
  { driver_name: "Rossi", country: "US", car_number: 96, car_colour: "#FEA621",
    position: 3, interval:0, pitting: false, last_lap: 0 },
  { driver_name: "Dixon", country: "AU", car_number: 9, car_colour: "#0064BF",
    position: 4, interval:0, pitting: false, last_lap: 0 },
  { driver_name: "Power", country: "AU", car_number: 12, car_colour: "#D80212",
    position: 5, interval: 0, pitting: false, last_lap: 0 },
  { driver_name: "Herta", country: "US", car_number: 98, car_colour: "#FF8000",
    position: 6, interval: 0, pitting: true, last_lap: 0 },
  { driver_name: "Hunter-Reay", country: "US", car_number: 28, car_colour: "#D80212",
    position: 7, interval: 0, pitting: false, last_lap: 0 },
  { driver_name: "Sato", country: "JP", car_number: 26, car_colour: "#0062BB",
    position: 8, interval: 0, pitting: false, last_lap: 0 },
  { driver_name: "Bourdais", country: "FR", car_number: 18, car_colour: "#D80212",
    position: 9, interval: 0, pitting: false, last_lap: 0 },
  { driver_name: "Hinchcliffe", country: "CA", car_number: 5, car_colour: "#4D4D4D",
    position: 10, interval: 0, pitting: false, last_lap: 0 }
]

# A very rough method of simulating interval times and lap times and
# sometimes overtakes resulting in position swaps
def mock_leaderboard
  overtake = (rand * 10).round == 7
  swap_at((rand * 9).floor) if overtake
  $state.each.with_index do |car, i|
    $state[i][:interval] = $state[i-1][:interval] - (rand * 4) if i != 0
    $state[i][:last_lap] = 39 + (rand * 3)
  end
  return $state
end

def swap_at(index)
  $state[index], $state[index+1] = $state[index+1], $state[index]
end

# Post the leaderboard result hash as json the LISTENER endpoint
def post_as_json(data)
  uri = URI.parse(LISTENER)
  http = Net::HTTP.new(uri.host, uri.port)
  http.read_timeout = 0.5
  begin
    request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' => 'application/json'})
    request.body = data.to_json
    http.request(request)
  rescue StandardError => e
    puts "Failed sending data: #{e.message}"
  end
end

def run
  while true
    leaderboard = mock_leaderboard
    puts "Sending: #{leaderboard.to_json}"
    post_as_json({leaderboard: leaderboard})
    sleep 0.5
  end
end

run