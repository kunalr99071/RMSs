class TicketsController < ApplicationController

  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
    @from = @ticket.from
    @to = @ticket.to
    @date = @ticket.date
    a = Station.find_by(station_name:@from)
    b = Station.find_by(station_name:@to)
    @total_distance = b.distance - a.distance
    @total_passenger = @ticket.passengers.count
    @fairprice = (@total_distance * 5)*@total_passenger 
    @routes = Route.all
    @route = Route.find_by(id:@ticket.route_id)
    @seats = @route.seats
    if @seats <= 0
      @seat_status = "waiting"
    else 
      @seat_status = "confirm"
    end
  end

  def payment 
  end

  def new 
    @ticket = Ticket.new   
  end
 
  def create  
    route = Route.find(params[:route_id])
    @ticket = route.tickets.new(ticket_params)
    @pnr = rand.to_s[2..7]


    respond_to do |format| 
   
      if @ticket.save 
        RailwayMailer.with(ticket: @ticket).welcome_email.deliver_now
        @ticket.update(pnr:@pnr)
        # redirect_to new_ticket_passenger_path(@ticket) 

        format.html { redirect_to(@ticket, notice: 'ticket was successfully created.') }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def ticket_params
    params.require(:ticket).permit(:from,:to,:date,:mobile,:email) 
  end

end
