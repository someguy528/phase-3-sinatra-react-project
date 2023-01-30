class Plane < ActiveRecord::Base
    has_many :flights
    has_many :bookings, through: :flights
    has_many :passengers, through: :bookings
end