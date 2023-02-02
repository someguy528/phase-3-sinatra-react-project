
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


end