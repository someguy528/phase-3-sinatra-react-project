class Booking < ActiveRecord::Base
    belongs_to :flight
    belongs_to :passenger

    def self.most_bookings
        booking = Booking.all.map{|booking| booking.passenger_id}.tally.sort_by{|k,v| -v}
        booking_all_max = booking.select{|b|  b[1] == booking[0][1]}
        booking_all_max
    end

end