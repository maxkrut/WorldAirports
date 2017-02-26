#GLOBAL
require(dplyr)
require(shiny)
require(shinythemes)
require(leaflet)
require(markdown)
require(geosphere)

airports_data <- read.table("airports.dat", sep = ',')[,2:12]
colnames(airports_data) <- c(
     'Name',	#Name of airport. May or may not contain the City name.
     'City',	#Main city served by airport. May be spelled differently from Name.
     'Country',	#Country or territory where airport is located. See countries.dat to cross-reference to ISO 3166-1 codes.
     'IATA',	#3-letter IATA code. Null if not assigned/unknown.
     'ICAO',	#4-letter ICAO code.
     #Null if not assigned.
     'Latitude',	#Decimal degrees, usually to six significant digits. Negative is South, positive is North.
     'Longitude',	#Decimal degrees, usually to six significant digits. Negative is West, positive is East.
     'Altitude',	#In meters.
     'Timezone',	#Hours offset from UTC. Fractional hours are expressed as decimals, eg. India is 5.5.
     'DST', #Daylight savings time. One of E (Europe), A (US/Canada), S (South America), O (Australia), Z (New Zealand), N (None) or U (Unknown). See also: Help: Time
     'Tz') #database time zone	Timezone in "tz" (Olson) format, eg. "America/Los_Angeles".
airports_data$Altitude <- round(airports_data$Altitude*0.3048,0)