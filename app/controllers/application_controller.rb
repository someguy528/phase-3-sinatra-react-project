require 'pry'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here

  # being used
  get "/planes" do
    Plane.all.to_json
  end
  
  # being used
  get "/flights" do
    Flight.all.to_json(except: :plane_id, include: [:plane , {
      bookings: {
        include: :passenger
      }
    }  ] )
  end

  # being used
  post "/flights" do
    flight = Flight.create(
      departure: params[:departure],
      destination: params[:destination],
      plane_id: params[:plane_id]
    )
    flight.to_json
  end

  # being used
  patch "/flights/:flight_id" do
    flight = Flight.find(params[:flight_id])
    flight.update(
      destination: params[:destination],
      plane_id: params[:plane_id],
      departure: params[:departure]
    )
    flight.to_json
  end

  # being used
  delete "/flights/:flight_id" do
    flight = Flight.find(params[:flight_id])
    flight.destroy
    flight.to_json
  end

  # being used to replace standard /booking route
  post "/flights/:flight_id/bookings" do
    passenger = Passenger.find_or_create_by(name: params[:name])
    new_Booking = Booking.create(
      seat: params[:seat],
      passenger_id: passenger[:id],
      flight_id: params[:flight_id]
    )
    new_Booking.to_json
  end

  # being used to replace standard /booking/:booking_id route
  patch "/flights/:flight_id/bookings/:booking_id" do
    pacthed_Booking = Booking.find(params[:booking_id])
    pacthed_Booking.update(
      seat: params[:seat]
    )
    pacthed_Booking.to_json
  end

  # being used to replace standard /booking/:booking_id route
  delete "/flights/:flight_id/bookings/:booking_id" do 
    deleted_booking = Booking.find(params[:booking_id])
    deleted_booking.destroy
    deleted_booking.to_json
  end

  # being used
  get '/bookings/most' do
    Booking.most_bookings.to_json
  end

  # being used
  get '/bookings/most_bookings_passengers' do
    Booking.most_bookings.map{|booking| Passenger.find_by(id: booking[0])}.to_json
  end



  # used for testing

  get "/planes/:id" do
    Plane.find(params[:id]).to_json(include: {
      flights: {
        except: [:plane_id], 
        include: { 
          bookings: {
            except: [:flight_id],
            include: :passenger
        }} }
    })
  end

  get "/bookings/:booking_id" do
    Booking.find(params[:booking_id]).to_json(include: :passenger)
  end

  get "/bookings" do
    Booking.all.to_json
  end

  get "/passengers" do
    Passenger.all.to_json
  end

  get "/passengers/:passenger_id" do
    Passenger.find(params[:passenger_id]).to_json(include: :bookings)
  end

  post "/passengers" do
    new_passenger = Passenger.create(
      name: params[:name]
    )
    new_passenger.to_json
  end

  patch "/passengers/:passenger_id" do
    patched_passenger = Passenger.find(params[:passenger_id])
    patched_passenger.update(
      name: params[:name]
    )
    patched_passenger.to_json
  end


end
