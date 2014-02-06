#!/usr/bin/ruby

require 'geocoder'

module BYSLocation 

	class BYSLocation

		def findNearbyByCity(cityName, state_id, radius)
			begin
		
				returnValue = []
		
				#1 find coordinates of the city.
				cityCoords = findCoordsByCityState(cityName, state_id)

puts "CITY COORDS: " + cityCoords.latitude.inspect.to_s + "/" + cityCoords.longitude.inspect.to_s 
				if not cityCoords.nil?
					#2 Find distance to each park and check to see if within search radius
					returnval = findNearbyParks(cityCoords, radius)
				end
		
				#3 return list
				return returnval
		
			rescue Exception => excptn
				puts "Exception found in findNearbyByCity: " + excptn.inspect.to_s
				return []
			end
		end

		def findNearbyByZip(postal_zip, radius)
			begin
			puts "findNearbyByZip"
				returnval = []
		
				zipCoords = findCoordsByZip(postal_zip)
				
				if not zipCoords.nil?
					puts "found " + zipCoords.latitude.to_s + " " + zipCoords.longitude.to_s
					returnval = findNearbyParks(zipCoords, radius)
				else
					puts "I have no idea where that is"
				end
				
				#3 return list
				return returnval
		
			rescue Exception => excptn
				puts "Exception in findNearbyByZip: " + excptn.inspect.to_s
				return []
			end
		end
		 
		def findNearbyByIP(ipAddress, radius)
			begin

				returnval = []

				ipCoords = findCoordsByIP(ipAddress)

				if not ipCoords.nil?
					returnval = findNearbyParks(ipCoords, radius)
				end

				#3 return list
				return returnval

			rescue Exception => excptn
				puts "Exception in findNearbyByIP: " + excptn.inspect.to_s
				return []
			end
		end
		
		def findCoordsByCityState(cityName, state_id)
			begin
				
				#First find all locations where name matches city name and state_id

				locations = Location.where("name like '%" + cityName + "%' and state_id = " + state_id.to_s)
		
				cityMatchFound = false
		
				if not locations.nil? and not locations[0].nil?
					#Look for a record with no zipcode (pure city location)
					location = locations[0]
					if location.latitude.nil? or location.longitude.nil?
						coords = geoFindCoordsByCityState(cityName,state_id)
						if not coords.nil?
							cityMatchFound = true
						end
					else
						coords = Coordinates.new
						coords.latitude = location.latitude
						coords.longitude = location.longitude
						cityMatchFound = true
					end
				end
		
				if not cityMatchFound
					# finally use geocodes to find city by name and state_id
					coords = geoFindCoordsByCityState(cityName, state_id)
					if not coords.nil?
						cityMatchFound = true
					end
				end
		
				if cityMatchFound == true
					return coords
				else
					return nil
				end
		
			rescue Exception => excptn
				puts "Exception found in findCoordsByCityState: " + excptn.inspect.to_s
				return nil
			end
		end





		def findCoordsByZip(postal_zip)
			begin
				
				#First find all locations where name matches city name and state_id
				locations = Location.where("postal_zip like '#{postal_zip}%'")

puts "LOCATIONS FOUND: " + locations.inspect.to_s

				postalZipMatchFound = false

				if not locations.nil? and not locations[0].nil?
puts "A"
#					if locations.kind_of?(Array)
puts "B"
						location = locations[0]
#					else
puts "C"
#						location = locations
#					end
puts "D"
					if location.latitude.nil? or location.longitude.nil?
puts "E"
						
							#last resort, find it using the geo lookup gem
							coords = geoFindCoordsByZip(postal_zip)
							if not coords.nil?
								postalZipMatchFound = true
							end
						
					else
puts "Pulled it right form Locations ... that was easy"
						coords = Coordinates.new
						coords.latitude = location.latitude
						coords.longitude = location.longitude
						postalZipMatchFound = true
					end
				else #locations nil
					coords = geoFindCoordsByZip(postal_zip)
					if not coords.nil?
						postalZipMatchFound = true
					end
				end

				if postalZipMatchFound == true
					return coords
				else
puts "couldn't find the zip code"					
					return nil
				end

			rescue Exception => excptn
				 puts "Exception in findZipCoords " + excptn.inspect.to_s
				 return nil 
			end
		end

		def removeEmptyLocations(locations)
			resultArray = Array.new
			locations.each do |location|
				if not location.latitude.nil? and not location.longitude.nil?
					resultArray << location
				end
			end
			return resultArray
		end

		def findCoordsByIP(address)
			begin
				coords = Coordinates.new

				#First find all locations where name matches ip address
				locations = Location.where("name like '%" + address + "%'")
				locations = removeEmptyLocations(locations)
				if locations.length > 0
					return locations
				else
					return []
				end
				#if we're here, locations table failed, currently disabled
				addressMatchFound = false

				if not location.nil?
					if location.latitude.nil? or location.longitude.nil?
						coords = geoFindCoordsByIP(address)
						if not coords.nil?
							addressMatchFound = true
						end
					else
						coords = Coordinates.new
						coords.latitude = location.latitude
						coords.longitude = location.longitude
						addressMatchFound = true
					end
				else
					coords = geoFindCoordsByIP(address)
					if not coords.nil?
						addressMatchFound = true
					end
				end
	 
				if addressMatchFound == true
					return coords
				else
					return nil
				end

			rescue Exception => excptn
				 puts "Exception in findCoordsByIP " + excptn.inspect.to_s
				 return nil 
			end
		end

		def findNearbyParks(coords, radius)#radius is in km
			begin
				if coords.nil?
					return []
				end

				returnval = []
				
				radius = radius.to_f
				
				latPlus = 0.01449275362 * radius
				latMinus = - latPlus
				latPlus += coords.latitude.to_f
				latMinus += coords.latitude.to_f

				lngPlus = 0.01639344262 * radius
				lngMinus = - lngPlus
				lngPlus += coords.longitude.to_f
				lngMinus += coords.longitude.to_f

				parks = Park.find_by_sql "SELECT * FROM parks where (latitude <= "+ latPlus.to_s + " and latitude >= " + latMinus.to_s + ") AND (longitude <= " + lngPlus.to_s + " and longitude >= " + lngMinus.to_s + ")"



				parks.each do |park|
					parkCoords = Coordinates.new
					parkCoords.latitude = park.latitude
					parkCoords.longitude = park.longitude
					distance = coords.calculateDistance(parkCoords)
					if distance < radius
						parkDistance = {:parkInfo => park, :distance => distance.round()}
						returnval << parkDistance
					end
				end
		
				return returnval
		
			rescue Exception => excptn
				puts "Exception in findNearbyParks: " + excptn.inspect.to_s
				return []
			end
		end
		
		
		def geoFindCityByCoords(coords) #returns city string
			begin
				geoObjectArray = Geocoder.search("" + coords.latitude + "," + coords.longitude)
				geoObject = fixAmbiguity (geoObjectArray)

				updateLocationsTable(geoObject, false)
				if geoObject
					return geoObject.city
				else
					return nil
				end
		
			rescue Exception => excptn
				puts "Exception found in geoFindCityByCoords: " + excptn.inspect.to_s
				return nil
			end
		end
		
		def geoFindCoordsByCityState(cityName, state_id) #returns coords
			begin
				state = State.find(state_id)
puts "searching for " + "" + cityName + ", " + state.name
				geoObjectArray = Geocoder.search("" + cityName + ", " + state.name)
				geoObject = fixAmbiguity (geoObjectArray)
				coords = makeCoordsFrom (geoObject)
				updateLocationsTable(geoObject, false)
				return coords
		
			rescue Exception => excptn
				puts "Exception found in geoFindCoordsByCityState: " + excptn.inspect.to_s
				return nil
			end
		end

		def geoFindCoordsByZip(postalZip) #returns coords
			begin
				geoObjectArray = Geocoder.search(postalZip)
				geoObject = fixAmbiguity (geoObjectArray)
				coords = makeCoordsFrom (geoObject)
puts coords.inspect
				updateLocationsTable(geoObject, true)
				return coords

			rescue Exception => excptn
				puts "Exception found in geoFindCoordsByZip: " + excptn.inspect.to_s
				return nil
			end
		end

		def geoFindCityByZip(postalZip) #returns address string 
			begin
				geoObjectArray = Geocoder.search(postalZip)
				geoObject = fixAmbiguity (geoObjectArray)
				updateLocationsTable(geoObject, false)
				if geoObject
					return geoObject.city
				else
					return nil
				end
			rescue Exception => excptn
				puts "Exception found in geoFindZipByCode: " + excptn.inspect.to_s
				return nil
			end
		end

		def geoFindCoordsByIP(ipAddress) #returns coords
			begin
				geoObjectArray = Geocoder.search(ipAddress)
				locations = Array.new
				geoObjectArray.each do |geoObject|
					locations << updateLocationsTable(geoObject, false)
				end
				locations.compact!
				return locations
			rescue Exception => excptn
				puts "Exception found in geoFindCoordsByIP: " + excptn.inspect.to_s
				return []
			end
		end

		def geoFindAddressByIP(ipAddress)
			begin
				geoObjectArray = Geocoder.search(ipAddress)
				geoObject = fixAmbiguity (geoObjectArray)
				updateLocationsTable(geoObject, false)
				if geoObject
					return geoObject.city
				else
					return nil
				end

			rescue Exception => excptn
				puts "Exception found in geoFindIPByAddress: " + excptn.inspect.to_s
				return nil
			end
		end

		def updateLocationsTable(geoObject, isZipCode) 
			#when searching by zip code, the geoObject name is the zip code
			#locations = Location.find_all_by_name_and_state_id(cityName, state_id)
			begin
				if (geoObject.nil?)
					return
				end
				arow = Location.new
				
				arow.latitude = geoObject.latitude
				arow.longitude = geoObject.longitude
				arow.state_id = State.where("abbrv like '" + geoObject.state_code + "'")[0].id
				arow.country_id = Country.where("abbrv like '%" + geoObject.country_code + "%'")[0].id

				if isZipCode == true
					arow.postal_zip = geoObject.address_components[0]["long_name"]
				else
					arow.name = geoObject.address_components[0]["long_name"]
				end
			rescue Exception => excptn
				puts "error in updateLocationsTable: " + excptn.inspect.to_s
				puts "state is " + geoObject.state_code
				puts "country is " + geoObject.country_code
				return nil #error creating the object, return nil because the data isn't reliable
			end
			begin
				arow.save
			rescue
				puts "updateLocationsTable: wasnt able to save the location.  MELTDOWN IMMINENT"
			end
			return arow #no way around returning this value :/
		end
		def fixAmbiguity (geoObjectArray)
			return geoObjectArray[0]
		end
		def makeCoordsFrom (geoObject)
			if geoObject.nil?
				return nil
			end
			coords = Coordinates.new
			coords.latitude = geoObject.latitude
			coords.longitude = geoObject.longitude
			return coords
		end

	end

	class Coordinates
		attr_accessor :longitude
		attr_accessor :latitude

		def initialize(latitude, longitude)
			self.longitude = longitude
			self.latitude = latitude
		end

		def initialize
			self.longitude = 0.0
			self.latitude = 0.0
		end

		def calculateDistance(target) #target is a coordinate
			begin
				theta = enforcePrecision(enforcePrecision(target.longitude.to_f) - enforcePrecision(self.longitude.to_f))
#puts "THETA: " + theta.to_s
				radTheta = enforcePrecision(deg2rad(theta))
#puts "RADTHETA: " + radTheta.to_s
				radParkLatitude = enforcePrecision(deg2rad(target.latitude))
#puts"RADPARKLAT: " + radParkLatitude.to_s
				radCityLatitude = enforcePrecision(deg2rad(self.latitude))
#puts "RADCITYLAT: " + radCityLatitude.to_s
				sinParkLatitude = enforcePrecision(Math.sin(radParkLatitude))
#puts "SINPARKLAT: " + sinParkLatitude.to_s
				sinCityLatitude = enforcePrecision(Math.sin(radCityLatitude))
#puts "SINCITYLAT: " + sinCityLatitude.to_s
				cosParkLatitude = enforcePrecision(Math.cos(radParkLatitude))
#puts "COSPARKLATITUDE: " + cosParkLatitude.to_s
				cosCityLatitude = enforcePrecision(Math.cos(radCityLatitude))
#puts "COSCITYLATITUDE: " + cosCityLatitude.to_s
				cosTheta = enforcePrecision(Math.cos(radTheta))
#puts "COSTHETA: " + cosTheta.to_s

				baseDistance = enforcePrecision(sinParkLatitude * sinCityLatitude) + enforcePrecision(cosParkLatitude * cosCityLatitude * cosTheta)
				if baseDistance > 1.0
					baseDistance = 1.0
				elsif baseDistance < -1.0
					baseDistance = -1.0
				end
#puts "BASEDISTANCE: " + baseDistance.to_s

				arcDistance = Math.acos(baseDistance)
				radDistance = rad2deg(arcDistance)
				kmDistance = radDistance * 111.19

				return kmDistance

			rescue Exception => excptn
				puts "Exception in Coordinates.distance: " + excptn.inspect.to_s
				puts "self info is "
				puts "lat: " + self.latitude.to_s + " lon: " + self.longitude.to_s + " base distance: " + baseDistance.to_s
				puts "target info is "
				puts "lat: " + target.latitude.to_s + " lon: " + target.longitude.to_s 
				return nil
			end
		end

		private

		def enforcePrecision(value)
			return value.round(5)
		end

		def isValidLatitude(latitude)
			begin
				if latitude
					if latitude.to_s != ""
						fLatitude = latitude.to_f
						if fLatitude >= 24.4667 #southernmost valid latitude
#puts "GOOD LATITUDE"
							bReturnval = true
						else
#puts "LAT VALUE TO SOUTHERLY : " + fLatitude.to_s
							bReturnval = false
						end
					else
#puts "LAT VALUE NULL STRING : " + latitude.to_s
						bReturnval = false
					end
				else
#puts "LAT VALUE NULL"
					bReturnval = false
				end

				return bReturnval

			rescue Exception => excptn
				bReturnval = false
				puts "Exception regarding latitude: " + excptn.inspect.to_s
				return bReturnval
			end
		end

		def isValidLongitude(longitude)
			begin
				if longitude
					if longitude.to_s != ""
						fLongitude = longitude.to_f
						if fLongitude <= -52.61944 #easternmost valid longitude 
#puts "GOOD LONGITUDE"
							bReturnval = true
						else
puts "LONG VALUE TOO EASTERLY : " + fLongitude.to_s
							bReturnval = false
						end
					else
puts "LONG VALUE NULL STRING : " + longitude.to_s
						bReturnval = false
					end
				else
puts "LONG VALUE NULL"
					bReturnval = false
				end

				return bReturnval

			rescue Exception => excptn
				bReturnval = false
				puts "Exception regarding longitude: " + excptn.inspect.to_s
				return bReturnval
			end
		end

		def deg2rad(degrees)
			begin
				radValue = enforcePrecision(degrees.to_f * 3.14159265359 / 180.0)

				return radValue

			rescue Exception => excptn
				bReturnval = nil
				puts "Exception calculating rad value: " + excptn.inspect.to_s
				return bReturnval
			end
		end

		def rad2deg(rads)
			begin
				degreeValue = enforcePrecision(rads.to_f * 180.0 / 3.14159265359)

				return degreeValue

			rescue Exception => excptn
				bReturnval = nil
				puts "Exception calculating degree value: " + excptn.inspect.to_s
				return bReturnval
			end
		end

		def convertToMiles(distance)
			begin

				returnval = distance / 1.6

				return returnval

			rescue Exception => excptn
				puts "Exception converting to miles: " + excptn.inspect.to_s
				return nil
			end
		end

	end
 
end

##############################################################################
##############################################################################
##############################################################################
##############################################################################

