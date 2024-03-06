class StationsController < ApplicationController

  def index 
    @stations = Station.all 
  end

  def new 
    @station = Station.new
  end
 
  def create  
    route = Route.find(params[:route_id])
    @station = route.stations.new(station_param)
     if @station.save 
       redirect_to route_stations_path 
     else
       render 'new'
     end
   end

  def station_param
    params.require(:station).permit(:station_name,:arrival,:departure,:distance,:seats) 
  end

end
