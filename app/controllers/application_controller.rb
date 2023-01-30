require 'pry'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/planes" do
    Plane.all.to_json(include: {
      flights: {
        except: [:plane_id],
        include: {
          bookings: {
            except: [:flight_id],
            include: :passenger
        }} }
    })
  end

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

  # being used
  get "/flights" do
    Flight.all.to_json(except: :plane_id, include: [:plane , {
      bookings: {
        include: :passenger
      }
    }  ] )
  end

  get "/flights/:flight_id" do
    Flight.find(params[:flight_id]).to_json(include: {
      bookings: {
        except: [:flight_id], 
        include: :passenger 
      }
    })
  end

  get "/flights/:flight_id/bookings" do
    Flight.find(params[:flight_id]).bookings.to_json(include: :passenger)
  end
  
  get "/flights/:flight_id/bookings/:booking_id" do
    Flight.find(params[:flight_id]).bookings.find(params[:booking_id]).to_json(include: :passenger)
  end
  
  post "/flights/:flight_id/bookings" do
    new_booking = Booking.create(
      flight_id: params[:flight_id],
      seat: params[:seat],
      passenger_id: params[:passenger_id]
    )
    new_booking.to_json
  end

  patch "/flights/:flight_id/bookings/:booking_id" do
    patched_booking = Booking.find(params[:booking_id])
    patched_booking.update(
      seat: params[:seat]
    )
    patched_booking.to_json
  end

  delete "/flights/:flight_id/bookings/:booking_id" do
    deleted_booking = Booking.find(params[:booking_id])
    deleted_booking.destroy
    deleted_booking.to_json
  end
  # separate bookings

  get "/bookings" do
    Booking.all.to_json
  end

  # being used
  get '/bookings/most' do
    Booking.most_bookings.to_json
  end
  get '/bookings/most_bookings_passengers' do
    Booking.most_bookings.map{|booking| Passenger.find_by(id: booking[0])}.to_json
  end

  get "/bookings/:booking_id" do
    Booking.find(params[:booking_id]).to_json(include: :passenger)
  end

  # being used
  post "/bookings" do
    passenger = Passenger.find_or_create_by(name: params[:name])
    new_Booking = Booking.create(
      seat: params[:seat],
      passenger_id: passenger[:id],
      flight_id: params[:flight_id]
    )
    new_Booking.to_json
  end

  # being used
  patch "/bookings/:booking_id" do
    pacthed_Booking = Booking.find(params[:booking_id])
    pacthed_Booking.update(
      seat: params[:seat]
    )
    pacthed_Booking.to_json
  end

  # being used
  delete "/bookings/:booking_id" do 
    deleted_booking = Booking.find(params[:booking_id])
    deleted_booking.destroy
    deleted_booking.to_json
  end

  get "/passengers" do
    Passenger.all.to_json
    # Passenger.all.to_json(include: {
    #   bookings: {
    #     except: [:flight_id, :passenger_id],
    #     include: :flight
    #   }})
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
