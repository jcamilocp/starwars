class V1::FilmsController < ApplicationController
  before_action :authenticate_user!, only: %i[index show create update destroy planets add_planet delete_planet people add_people delete_people]

  rescue_from Exception do |e|
    render json: { error: e.message }, status: :internal_server_error
  end

  rescue_from ActiveRecord::ActiveRecordError do |e|
    render json: { error: e.message }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # GET /v1/films
  def index
    @films = Film.all

    render json: { films: @films }, status: :ok
  end

  # GET /v1/films/:id
  def show
    @film = Film.find(params[:id])

    render json: { film: @film }, status: :ok
  end

  # POST /v1/films
  def create
    @film = Film.create!(create_params)

    render json: { film: @film }, status: :created
  end

  # PUT /v1/films/:id
  def update
    @film = Film.find(params[:id])
    @film.update!(update_params)

    render json: { film: @film }, status: :ok
  end

  # DELETE /v1/films/:id
  def destroy
    @film = Film.find(params[:id])
    @film.destroy

    render json: {}, status: :no_content
  end

  # GET /v1/films/:id/planets
  def planets
    @planets = Film.find(params[:id]).planets

    render json: { planets: @planets }, status: :ok
  end

  # POST /v1/films/:id/planets
  def add_planet
    planet = Planet.find(params[:planet][:id])
    @planets = Film.find(params[:id]).planets
    @planets.push(planet)

    render json: { planets: @planets }, status: :created
  end

  # DELETE /v1/films/:film_id/planet/:film_id
  def delete_planet
    planet = Planet.find(params[:planet_id])
    @planets = Film.find(params[:film_id]).planets
    @planets.delete(planet)

    render json: {}, status: :no_content
  end

  # GET /v1/films/:id/people
  def people
    @people = Film.find(params[:id]).people

    render json: { people: @people }, status: :ok
  end

  # POST /v1/films/:id/people
  def add_people
    peep = People.find(params[:people][:id])
    @people = Film.find(params[:id]).people
    @people.push(peep)

    render json: { people: @people }, status: :created
  end

  # DELETE /v1/films/:film_id/planet/:film_id
  def delete_people
    peep = People.find(params[:people_id])
    @people = Film.find(params[:film_id]).people
    @people.delete(peep)

    render json: {}, status: :no_content
  end

  private

  def create_params
    params.require(:film).permit(:title, :opening_crawl, :director, :episode_id, :producer, :release_date)
  end

  def update_params
    params.require(:film).permit(:title, :opening_crawl, :director, :producer, :release_date)
  end
end
