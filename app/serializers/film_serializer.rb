class FilmSerializer
  include JSONAPI::Serializer
  attributes :title, :episode_id, :opening_crawl, :director, :producer, :release_date, :planets, :people
end
