class Station < ApplicationRecord
  belongs_to :route, foreign_key: "route_id"
  
  def self.ransackable_attributes(auth_object = nil)
    ["arrival", "created_at", "departure", "distance", "id", "route_id", "seats", "station_name", "updated_at"]
  end
end
