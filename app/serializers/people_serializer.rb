class PeopleSerializer
  include JSONAPI::Serializer
  attributes :name, :birth_year, :eye_color, :gender, :hair_color, :height, :mass, :skin_color, :planet
end
