class V1::PlanetsController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]

  rescue_from Exception do |e|
    render json: { error: e.message }, status: :internal_server_error
  end

  rescue_from ActiveRecord::ActiveRecordError do |e|
    render json: { error: e.message }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # GET /v1/planets
  def index
    @planets = Planet.all

    render json: { planets: @planets }, status: :ok
  end

  # GET /v1/planets/:id
  def show
    @planet = Planet.find(params[:id])

    render json: { planet: @planet }, status: :ok
  end

  # POST /v1/planets
  def create
    @planet = Planet.create!(create_params)

    render json: { planet: @planet }, status: :created
  end

  # PUT /v1/planets/:id
  def update
    @planet = Planet.find(params[:id])
    @planet.update!(update_params)

    render json: { planet: @planet }, status: :ok
  end

  # DELETE /v1/planets/:id
  def destroy
    @planet = Planet.find(params[:id])
    @planet.destroy

    render json: { planet: {} }, status: :ok
  end

  private

  def create_params
    params.require(:planet).permit(:name, :diameter, :rotation_period, :orbital_period, :gravity, :population, :climate, :terrain, :surface_water)
  end

  def update_params
    params.require(:planet).permit(:name, :diameter, :rotation_period, :orbital_period, :gravity, :population, :climate, :terrain, :surface_water)
  end
end
