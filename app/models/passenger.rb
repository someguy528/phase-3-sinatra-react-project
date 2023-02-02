class Passenger < ActiveRecord::Base
    has_many :bookings
    has_many :flights, through: :bookings
    has_many :planes, through: :flights

    def self.most_bookings_passengers
        bookings = Booking.sorted_bookings
        max = Booking.most_bookings_amt
        passengers_with_bookings = bookings.select{|b|  b[1] == max}
        passengers_with_bookings.map{|i| Passenger.find(i[0]).name}
    end

    def self.passengers_grouped_with_bookings
        bookings = Booking.sorted_bookings
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