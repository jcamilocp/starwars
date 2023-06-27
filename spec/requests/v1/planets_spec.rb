require 'rails_helper'

RSpec.describe 'V1::Planets', type: :request do
  let!(:user) { create(:user) }

  req_payload = {
    planet: {
      name: Faker::Lorem.sentence(word_count: 2),
      diameter: Faker::Lorem.sentence(word_count: 2),
      rotation_period: Faker::Lorem.sentence(word_count: 2),
      orbital_period: Faker::Lorem.sentence(word_count: 2),
      gravity: Faker::Lorem.sentence(word_count: 2),
      population: Faker::Lorem.sentence(word_count: 2),
      climate: Faker::Lorem.sentence(word_count: 2),
      terrain: Faker::Lorem.sentence(word_count: 2),
      surface_water: Faker::Lorem.sentence(word_count: 2)
    }
  }

  describe 'GET /v1/planets' do
    describe 'with auth' do
      before { sign_in user }

      it 'should return OK' do
        get '/v1/planets'
        expect(response).to have_http_status(:ok)
      end

      describe 'with data in the DB' do
        let!(:planets) { create_list(:planet, 10) }
        it 'should return all planets' do
          get '/v1/planets'
          payload = JSON.parse(response.body)
          expect(response).to have_http_status(:ok)
          expect(payload['planets'].size).to eq(planets.size)
        end
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        get '/v1/planets'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /v1/planets/:id' do
    let!(:planet) { create(:planet) }

    describe 'with auth' do
      before { sign_in user }

      it 'should return OK' do
        get "/v1/planets/#{planet.id}"
        expect(response).to have_http_status(:ok)
      end

      it 'should return the correct planet' do
        get "/v1/planets/#{planet.id}"
        payload = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(payload['planet']['id']).to eq(planet.id)
        expect(payload['planet']['name']).to eq(planet.name)
      end

      it 'should return an error when the record doesn\'t exist' do
        get '/v1/planets/0'
        expect(response).to have_http_status(:not_found)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        get "/v1/planets/#{planet.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /v1/planets' do
    describe 'with auth' do
      before { sign_in user }

      it 'should create the planet' do
        post '/v1/planets', params: req_payload
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(response).to have_http_status(:created)
        expect(payload['planet']['id']).to_not be_nil
      end

      it 'should return an error if the payload is wrong' do
        wrong_payload = {
          planet: {
            name: 'wrong planet',
            diameter: nil
          }
        }

        post '/v1/planets', params: wrong_payload
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        post '/v1/planets', params: req_payload
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /v1/planets' do
    let!(:planet) { create(:planet) }

    describe 'with auth' do
      before { sign_in user }

      it 'should update the planet' do
        put "/v1/planets/#{planet.id}", params: req_payload
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(response).to have_http_status(:ok)
        expect(payload['planet']['name']).to eq(req_payload[:planet][:name])
      end

      it 'should return an error if the payload is wrong' do
        wrong_payload = {
          planet: { name: nil }
        }
        put "/v1/planets/#{planet.id}", params: wrong_payload
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        put "/v1/planets/#{planet.id}", params: req_payload
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /v1/planets/:id' do
    let!(:planets) { create_list(:planet, 10) }

    describe 'with auth' do
      before { sign_in user }

      it 'should delete the planet' do
        delete "/v1/planets/#{planets[0].id}"
        expect(response.body).to be_empty
        expect(response).to have_http_status(:no_content)
        expect(Planet.all.size).to eq(9)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        delete "/v1/planets/#{planets[0].id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /v1/planets/:id/films' do
    let!(:planet1) { create(:planet) }
    let!(:film1) { create(:film) }
    let!(:film2) { create(:film) }
    let!(:filmplanet1) { create(:film_planet, planet_id: planet1.id, film_id: film1.id) }
    let!(:filmplanet2) { create(:film_planet, planet_id: planet1.id, film_id: film2.id) }

    describe 'with auth' do
      before { sign_in user }

      it 'should list the films of the planet' do
        get "/v1/planets/#{planet1.id}/films"
        payload = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(payload['films'].size).to eq(2)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        get "/v1/planets/#{planet1.id}/films"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /v1/planets/:id/films' do
    let!(:planet) { create(:planet) }
    let!(:film) { create(:film) }

    describe 'with auth' do
      before { sign_in user }

      it 'should create the films for the planet' do
        post "/v1/planets/#{planet.id}/films", params: { film: { id: film.id } }
        payload = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(payload['films'].size).to eq(1)
        expect(Planet.find(planet.id).films.size).to eq(1)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        post "/v1/planets/#{planet.id}/films", params: { film: { id: film.id } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
