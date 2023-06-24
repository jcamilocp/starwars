class V1::PeopleController < ApplicationController
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

  # GET /v1/people
  def index
    @people = People.all

    render json: { people: @people }, status: :ok
  end

  # GET /v1/people/:id
  def show
    @people = People.find(params[:id])

    render json: { people: @people }, status: :ok
  end

  # POST /v1/people
  def create
    @people = People.create!(create_params)

    render json: { people: @people }, status: :created
  end

  # PUT /v1/people/:id
  def update
    @people = People.find(params[:id])
    @people.update!(update_params)

    render json: { people: @people }, status: :ok
  end

  # DELETE /v1/people/:id
  def destroy
    @people = People.find(params[:id])
    @people.destroy

    render json: {}, status: :no_content
  end

  private

  def create_params
    params.require(:people).permit(:name, :birth_year, :eye_color, :gender, :hair_color, :height, :mass, :skin_color, :planet_id)
  end

  def update_params
    params.require(:people).permit(:name, :birth_year, :eye_color, :gender, :hair_color, :height, :mass, :skin_color)
  end
end
