require './line'
require './station'
require './fancy_gets'
require 'yaml'

require 'pry'


include FancyGets

class Widget
  include FancyGets
end

w = Widget.new
# w.gets_auto_suggest()

@lines_raw = [{name: "Bakerloo Line", forwards_direction: "north", backwards_direction: "south", stations: ["Queen's Park", "Kilburn Park", "Maida Vale", "Warwick Avenue", "Paddington", "Edgware Road", "Marylebone", "Baker Street", "Regent's Park", "Oxford Circus", "Piccadilly Circus", "Charing Cross", "Embankment", "River Thames", "Waterloo", "Lambeth North", "Elephant & Castle"]},
{name: "Central Line", forwards_direction: "", backwards_direction: "", stations: ["Leytonstone", "Leyton", "Stratford", "Mile End", "Bethnal Green", "Liverpool Street", "Bank", "St. Paul's", "Chancery Lane", "Holborn", "British Museum", "Tottenham Court Road", "Oxford Circus", "Bond Street", "Marble Arch", "Lancaster Gate", "Queensway", "Notting Hill Gate", "Holland Park"]},
{name: "Circle Line", forwards_direction: "", backwards_direction: "", stations: ["Hammersmith", "Goldhawk Road", "Shepherd's Bush Market", "Wood Lane", "Latimer Road", "Ladbroke Grove", "Westbourne Park", "Royal Oak", "Paddington Mainline Station (Platforms ", "Edgware Road", "Baker Street", "Great Portland Street", "Euston Square", "Farringdon", "Barbican", "Moorgate", "Liverpool Street", "Aldgate", "Tower Hill", "Monument", "Cannon Street", "Mansion House", "Blackfriars", "Temple", "Embankment", "Westminster", "St. James's Park", "Victoria", "Sloane Square", "South Kensington", "Gloucester Road", "High Street Kensington", "Notting Hill Gate", "Bayswater", "Edgware Road"]},
{name: "District - Ealing Broadway Branch (to Bow Road)", forwards_direction: "", backwards_direction: "", stations: ["Ealing Broadway", "Ealing Common", "Acton Town", "Chiswick Park", "Turnham Green", "Stamford Brook", "Ravenscourt Park", "Hammersmith", "Barons Court", "West Kensington", "Kensington (Olympia)", "Earl's Court", "Gloucester Road", "South Kensington", "Sloane Square", "Victoria", "St. James's Park", "Westminster", "Embankment", "Temple", "Blackfriars", "Mansion House", "Cannon Street", "Monument", "Tower Hill", "Aldgate East", "Whitechapel", "Stepney Green", "Mile End", "Bow Road"]},
{name: "District Turnham Green to Edgware Road", forwards_direction: "", backwards_direction: "", stations: ["Turnham Green", "Stamford Brook", "Ravenscourt Park", "Hammersmith", "Barons Court", "West Kensington", "Kensington (Olympia)", "Earl's Court", "High Street Kensington", "Notting Hill Gate", "Bayswater", "Paddington", "Edgware Road"]},
{name: "District Wimbledon to Bow Road", forwards_direction: "", backwards_direction: "", stations: ["Wimbledon", "Wimbledon Park", "Southfields", "East Putney", "Putney Bridge", "Parsons Green", "Fulham Broadway", "West Brompton", "Earl's Court", "Gloucester Road", "South Kensington", "Sloane Square", "Victoria", "St. James's Park", "Westminster", "Embankment", "Temple", "Blackfriars", "Mansion House", "Cannon Street", "Monument", "Tower Hill", "Aldgate East", "Whitechapel", "Stepney Green", "Mile End", "Bow Road"]},
{name: "District - Kensington Olympia Branch", forwards_direction: "", backwards_direction: "", stations: ["Wimbledon", "Wimbledon Park", "Southfields", "East Putney", "Putney Bridge", "Parsons Green", "Fulham Broadway", "West Brompton", "Earl's Court", "High Street Kensington", "Notting Hill Gate", "Bayswater", "Paddington", "Edgware Road"]},
{name: "Hammersmith & City Line", forwards_direction: "", backwards_direction: "", stations: ["Hammersmith", "Goldhawk Road", "Shepherd's Bush Market", "White City", "Wood Lane", "Latimer Road", "Ladbroke Grove", "Westbourne Park", "Royal Oak", "Paddington", "Edgware Road", "Baker Street", "Great Portland Street", "Euston Square", "King's Cross St. Pancras", "Farringdon", "Barbican", "Moorgate", "Liverpool Street", "Aldgate East", "St. Mary's (Whitechapel Road)", "Whitechapel", "Stepney Green", "Mile End", "Bow Road"]},
{name: "Jubilee Line", forwards_direction: "", backwards_direction: "", stations: ["Stanmore", "Canons Park", "Queensbury", "Kingsbury", "Wembley Park", "Neasden", "Dollis Hill", "Willesden Green", "Kilburn", "West Hampstead", "Finchley Road", "Swiss Cottage", "St. John's Wood", "Baker Street", "Bond Street", "Green Park", "Charing Cross", "Aldwych", "Ludgate Circus", "Cannon Street", "Fenchurch Street"]},
{name: "Metropolitan Line", forwards_direction: "", backwards_direction: "", stations: ["Aldgate", "Baker Street", "Finchley Road", "Wembley Park", "Preston Road", "Northwick Park", "Harrow-on-the-Hill", "West Harrow", "Rayners Lane"]},
{name: "Northern Line - Bank branch", forwards_direction: "", backwards_direction: "", stations: ["Edgware", "Burnt Oak", "Colindale", "Hendon Central", "Brent Cross", "Golders Green", "North End", "Hampstead", "Belsize Park", "Chalk Farm", "Camden Town", "Mornington Crescent", "Euston", "King's Cross St. Pancras", "Angel", "City Road", "Old Street", "Moorgate", "Lothbury", "Bank", "London Bridge", "Borough", "Elephant & Castle", "Kennington", "Oval", "Stockwell", "Clapham North", "Clapham Common", "Clapham South", "Balham", "Tooting Bec", "Tooting Broadway", "Colliers Wood", "South Wimbledon", "Morden"]},
{name: "Northern Line - Charing Cross Branch", forwards_direction: "", backwards_direction: "", stations: ["High Barnet", "Totteridge and Whetstone", "Woodside Park", "West Finchley", "Finchley Central", "East Finchley", "Highgate", "Archway", "Tufnell Park", "Kentish Town", "Camden Town", "Mornington Crescent", "Euston", "Warren Street", "Goodge Street", "Tottenham Court Road", "Leicester Square", "Charing Cross", "Embankment", "Waterloo", "Kennington"]},
{name: "Northern - ?????", forwards_direction: "", backwards_direction: "", stations: ["Highgate", "Archway", "Tufnell Park", "Kentish Town", "South Kentish Town", "Crouch End", "Stroud Green", "Finsbury Park", "Drayton Park", "Highbury & Islington", "Essex Road", "Nine Elms"]},
{name: "Piccadilly Line - Uxbridge Branch", forwards_direction: "", backwards_direction: "", stations: ["Cockfosters", "Oakwood", "Southgate", "Arnos Grove", "Bounds Green", "Wood Green", "Turnpike Lane", "Manor House", "Finsbury Park", "Arsenal", "Holloway Road", "Caledonian Road", "York Road", "King's Cross St. Pancras", "Russell Square", "Holborn", "Aldwych", "Covent Garden", "Leicester Square", "Piccadilly Circus", "Green Park", "Down Street", "Hyde Park Corner", "Knightsbridge", "Brompton Road", "South Kensington", "Gloucester Road", "Earl's Court", "Barons Court", "Hammersmith", "Acton Town", "Ealing Common", "North Ealing", "Park Royal", "Park Royal & Twyford Abbey", "Alperton", "Sudbury Town", "Sudbury Hill", "South Harrow", "Rayners Lane", "Uxbridge"]},
{name: "Piccadilly Line - Heathrow Branch", forwards_direction: "", backwards_direction: "", stations: ["Cockfosters", "Oakwood", "Southgate", "Arnos Grove", "Bounds Green", "Wood Green", "Turnpike Lane", "Manor House", "Finsbury Park", "Arsenal", "Holloway Road", "Caledonian Road", "York Road", "King's Cross St. Pancras", "Russell Square", "Holborn", "Aldwych", "Covent Garden", "Leicester Square", "Piccadilly Circus", "Green Park", "Down Street", "Hyde Park Corner", "Knightsbridge", "Brompton Road", "South Kensington", "Gloucester Road", "Earl's Court", "Barons Court", "Hammersmith", "Acton Town", "South Ealing", "Northfields", "Boston Manor", "Osterley", "Hounslow East", "Hounslow Central", "Hounslow West", "Hatton Cross", "Heathrow T123", "Heathrow Terminal 5"]},
{name: "Victoria Line", forwards_direction: "", backwards_direction: "", stations: ["Walthamstow Central", "Blackhorse Road", "Tottenham Hale", "Seven Sisters", "Finsbury Park", "Highbury & Islington", "King's Cross St. Pancras", "Euston", "Warren Street", "Oxford Circus", "Green Park", "Victoria", "Pimlico", "Vauxhall", "Stockwell", "Brixton"]},
{name: "Waterloo & City Line", forwards_direction: "", backwards_direction: "", stations: ["Bank", "Waterloo"]}]


def line_names
  @lines_raw.map do |line|
    "#{line[:name]} - #{line[:stations].count}"
  end
end

# Build a pile of lines
all_lines = []
all_stations = []

@lines_raw.each do |line|
  new_line = Line.new(line[:name], line[:forwards_direction], line[:backwards_direction])
  new_line.stations = line[:stations]
  # With this list of station names, make sure all_stations is up to date
  new_line.stations.each do |station_name|
    existing_station = all_stations.select { |station| station.name == station_name }.first
    # If we haven't seen this station yet, build it ...
    unless existing_station
      all_stations << Station.new(station_name, new_line)
    else
      # ... otherwise add this line as connecting to this station
      existing_station.lines << new_line
    end
  end
  all_lines << new_line
end

binding.pry

File.open("stations.yml","w") do |file|
  file.write all_stations.to_yaml
end


# For the auto matching it's nice to have things sorted
all_stations.sort!

# Project requirements:

# As a user, I should not be able to navigate directly to stations that I cannot
#   access with one train ride
# As a user, after navigating I should see which line I rode on to get to
#   this current station
# As a user, I should see the number of stops along the way it took to get me to
#   this station
# As a user, I should be able to type a number to indicate which station to go to

my_station = all_stations[100]
loop do
  puts "You find yourself at #{all_stations.index(my_station) + 1}: #{my_station.name}"
  puts "Here are all the stations available from here:"
  puts my_station.lines.map { |line| "#{line.name} -- #{(line.stations - [my_station.name]).join(", ")}" }.join("\n\n")
  puts "Where would you like to end up next?"

  new_station_name = gets_auto_suggest(all_stations.map(&:name))

  my_station = all_stations.select { |station| station.name == new_station_name }.first
end
