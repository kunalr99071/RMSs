class PassengersController < ApplicationController

  def index 
  
    @passengers = Passenger.all
    @ticket = Ticket.find(params[:ticket_id])

    @routes = Route.all
    @route = Route.find_by(id:@ticket.route_id)
    @seats = @route.seats
    # @route_ticket = Ticket.where(route_id:@route.id)

    # @route_ticket.each do |r|
    #   @passenger_count = @passenger_count + r.passengers.count
    # end         
    # @seats = @seats - @passenger_count
    if @seats <= 0
      @seat_status = "waiting"
    else 
      @seat_status = "confirm"
    end
  end 

  
  def new 
    @passenger = Passenger.new
   end
 
  def create  
    @ticket = Ticket.find(params[:ticket_id])
    @passenger = @ticket.passengers.new(passenger_params)
    @route = Route.find_by(id:@ticket.route_id)
    @seats = @route.seats
     if @passenger.save 
      @seats = @seats - 1 
      # @route.update(seats:@seats)
      redirect_to ticket_passengers_path 
     else
       render 'new', status: :unprocessable_entity 
     end
   end

  def passenger_params
    params.require(:passenger).permit(:name,:age,:mobile,:gender,:ticket_id) 
  end

end
