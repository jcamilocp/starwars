class V1::FilmsController < ApplicationController
  before_action :authenticate_user!, only: %i[index show create update destroy]

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

    render json: { film: {} }, status: :ok
  end

  private

  def create_params
    params.require(:film).permit(:title, :opening_crawl, :director, :episode_id, :producer, :release_date)
  end

  def update_params
    params.require(:film).permit(:title, :opening_crawl, :director, :producer, :release_date)
  end
end
