class RoutesController < ApplicationController
  
  def index
    @routes = Route.all
  end


  def search 
    # binding.b
    @routes = Route.all
    @from= params[:from]
    @to= params[:to]
    @date = params[:date]
    @passenger_count = 0
    @all_station = Station.eager_load(:route)
     @s_name = @all_station.pluck(:station_name)
      # @s_name  = @all_station.where(route_id:route.id).pluck(:station_name)

      if (@s_name.include?(@from) && @s_name.include?(@to))
        @a = Station.find_by(station_name:@from) 
        @b = Station.find_by(station_name:@to) 

        if (@a.route_id == @b.route_id)

          if @a.id < @b.id
            @departure = @a.departure
            @arrival = @b.arrival
            @total_distance = @b.distance - @a.distance
            @fairprice = (@total_distance * 5) 
            @route = Route.find_by(id:@a.route_id)
            @seats = @route.seats
            @route_ticket = Ticket.where(route_id:@route.id)

            @route_ticket.each do |r|
              @passenger_count = @passenger_count + r.passengers.count
            end
            
            @seats = @seats - @passenger_count

            # @route.update(seats:@seats)

            if @seats <= 0
              @seat_status = "#{@seats*-1}-waiting"
            else 
              @seat_status = "#{@seats}-Available"
            end
            
          else 
            redirect_to root_path
            flash[:message] = "No train available"
          end

        else 
          redirect_to root_path
          flash[:message] = "No train available"
        end

      else 
        #redirect_to root_path
        flash[:message] = "No train available"
      end
  end



  def pnr 
    @routes = Route.all
    @pnr = params[:pnr]
    # @ticke = Ticket.find_by(pnr:@pnr)
    if @seats <= 0
      @status = "waiting"
    else 
      @status = "confirm"
    end
  end

  # def new 
  #  @route = Route.new
  #  end
 
  # def create  
  #  @route = Route.new(route_param)
  #    if @route.save 
  #      redirect_to root_path 
  #    else
  #      render 'new'
  #    end
  #  end

  # def route_param
  #   params.require(:route).permit(:name) 
  # end

end
