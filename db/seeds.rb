require 'faker'
require 'time'

puts "🌱 Seeding data..."
# Seed your database here

# datetime.to_formatted_s(:rfc822) 
# datetime.new(2023,5,7).to_formatted_s(:long)

# generate passengers
puts "Creating Passengers"
50.times do |i|
    Passenger.create(name: Faker::Name.name)  
end


# generate planes 
puts "Creating Planes"
planes = ["Experimental Plane 1", "Experimental Plane 2", "Experimental Plane 3"]
planes.each{|plane| Plane.create(name: plane, capacity: 20, condition: "Top Shape!") }


# generate flights
puts "Creating flights"
destinations = ["Miami" , "Las Vegas" , "Los Angeles"]
x = 2
destinations.each do |destination|

    planes.each do |plane|
        Flight.create(
            destination: destination, 
            departure: Date.new(2023, 7, x).to_s, 
            plane_id: Plane.find_by(name: plane).id )
        x += 2    
    end
    
end

# generate seats
puts "Creating seats"
seats_array = [* "A01".."A10" , * "B01".."B10"]

# generate bookings
puts "Creating bookings"
passenger_array = Passenger.all

Flight.all.each do |flight_hash|
    shuffled_passengers = passenger_array.shuffle.slice(0, 20)

    # flight_seats = Seat.all.where("plane_id = ? ", flight_hash.plane_id)
    
    shuffled_passengers.each_with_index do |shuf_pass, index|
                Booking.create(   
                    # seat_id: seats_array[index] ,
                    seat: seats_array[index], 
                    flight_id: flight_hash.id,
                    passenger_id: shuf_pass.id
                    )
    end
end

puts "✅ Done seeding!"
