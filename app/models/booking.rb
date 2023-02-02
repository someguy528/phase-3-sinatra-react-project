
class Booking < ActiveRecord::Base 
    belongs_to :flight
    belongs_to :passenger

    def self.sorted_bookings
        Booking.all.map{|booking| booking.passenger_id}.tally.sort_by{|k,v| -v}
    end

    def self.most_bookings_amt
        bookings = self.sorted_bookings
        bookings.max_by{|k,v| v}[1]
    end

    def self.most_bookings_passengers
        bookings = self.sorted_bookings
        max = self.most_bookings_amt
        passengers_with_bookings = bookings.select{|b|  b[1] == max}
        passengers_with_bookings.map{|i| Passenger.find(i[0]).name}
    end

    def self.passengers_grouped_with_bookings
        bookings = self.sorted_bookings
        chunked_bookings = bookings.chunk{|i| i[1]}
        chunked_bookings.map do |i|
            array = i[1].map do |j|
                "#{Passenger.find(j[0]).name}"
            end
            names = array.join(", ")
            i[0] > 1 ? book = "Bookings" : book = "Booking"
            "These Passengers have #{i[0]} #{book} : #{names}" 
        end
    end

end