class Flight < ActiveRecord::Base
    belongs_to :plane
    has_many :bookings
    has_many :passengers, through: :bookings
end