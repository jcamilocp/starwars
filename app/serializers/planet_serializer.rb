class PlanetSerializer
  include JSONAPI::Serializer
  attributes :name, :diameter, :rotation_period, :orbital_period, :gravity, :population, :climate, :terrain, :surface_water
end
