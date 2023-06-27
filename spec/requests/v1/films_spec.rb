require 'rails_helper'

RSpec.describe "V1::Films", type: :request do
  let!(:user) { create(:user) }

  req_payload = {
    film: {
      title: Faker::Lorem.sentence(word_count: 2),
      episode_id: rand(0..10),
      opening_crawl: Faker::Lorem.sentence(word_count: 2),
      director: Faker::Lorem.sentence(word_count: 2),
      producer: Faker::Lorem.sentence(word_count: 2),
      release_date: Time.at(Time.now + rand * (0.0.to_f - Time.now.to_f))
    }
  }

  describe 'GET /v1/films' do
    describe 'with auth' do
      before { sign_in user }

      it 'should return OK' do
        get '/v1/films'
        expect(response).to have_http_status(:ok)
      end

      describe 'with data in the DB' do
        let!(:films) { create_list(:film, 10) }
        it 'should return all films' do
          get '/v1/films'
          payload = JSON.parse(response.body)
          expect(response).to have_http_status(:ok)
          expect(payload['films'].size).to eq(films.size)
        end
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        get '/v1/films'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /v1/films/:id' do
    let!(:film) { create(:film) }

    describe 'with auth' do
      before { sign_in user }

      it 'should return OK' do
        get "/v1/films/#{film.id}"
        expect(response).to have_http_status(:ok)
      end

      it 'should return the correct film' do
        get "/v1/films/#{film.id}"
        payload = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(payload['film']['id']).to eq(film.id)
        expect(payload['film']['title']).to eq(film.title)
      end

      it 'should return an error when the record doesn\'t exist' do
        get '/v1/films/0'
        expect(response).to have_http_status(:not_found)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        get "/v1/films/#{film.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /v1/films' do
    describe 'with auth' do
      before { sign_in user }

      it 'should create the film' do
        post '/v1/films', params: req_payload
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(response).to have_http_status(:created)
        expect(payload['film']['id']).to_not be_nil
      end

      it 'should return an error if the payload is wrong' do
        wrong_payload = {
          film: {
            title: 'wrong film',
            diameter: nil
          }
        }

        post '/v1/films', params: wrong_payload
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        post '/v1/films', params: req_payload
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /v1/films' do
    let!(:film) { create(:film) }

    describe 'with auth' do
      before { sign_in user }

      it 'should update the film' do
        put "/v1/films/#{film.id}", params: req_payload
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(response).to have_http_status(:ok)
        expect(payload['film']['title']).to eq(req_payload[:film][:title])
      end

      it 'should return an error if the payload is wrong' do
        wrong_payload = {
          film: { title: nil }
        }
        put "/v1/films/#{film.id}", params: wrong_payload
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        put "/v1/films/#{film.id}", params: req_payload
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /v1/films/:id' do
    let!(:films) { create_list(:film, 10) }

    describe 'with auth' do
      before { sign_in user }

      it 'should delete the film' do
        delete "/v1/films/#{films[0].id}"
        # payload = JSON.parse(response.body)
        expect(response.body).to be_empty
        expect(response).to have_http_status(:no_content)
        expect(Film.all.size).to eq(9)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        delete "/v1/films/#{films[0].id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /v1/films/:id/planets' do
    let!(:film1) { create(:film) }
    let!(:planet1) { create(:planet) }
    let!(:planet2) { create(:planet) }
    let!(:filmplanet1) { create(:film_planet, planet_id: planet1.id, film_id: film1.id) }
    let!(:filmplanet2) { create(:film_planet, planet_id: planet2.id, film_id: film1.id) }

    describe 'with auth' do
      before { sign_in user }

      it 'should list the planets of the film' do
        get "/v1/films/#{film1.id}/planets"
        payload = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(payload['planets'].size).to eq(2)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        get "/v1/films/#{film1.id}/planets"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /v1/films/:id/planets' do
    let!(:planet) { create(:planet) }
    let!(:film) { create(:film) }

    describe 'with auth' do
      before { sign_in user }

      it 'should create the planet for the film' do
        post "/v1/films/#{film.id}/planets", params: { planet: { id: planet.id } }
        payload = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(payload['planets'].size).to eq(1)
        expect(Film.find(film.id).planets.size).to eq(1)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        post "/v1/films/#{film.id}/planets", params: { planet: { id: planet.id } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE  /v1/films/:film_id/planets/:planet_id' do
    let!(:film1) { create(:film) }
    let!(:planet1) { create(:planet) }
    let!(:planet2) { create(:planet) }
    let!(:filmplanet1) { create(:film_planet, planet_id: planet1.id, film_id: film1.id) }
    let!(:filmplanet2) { create(:film_planet, planet_id: planet2.id, film_id: film1.id) }

    describe 'with auth' do
      before { sign_in user }

      it 'should delete the planet for the film' do
        expect(Film.find(film1.id).planets.size).to eq(2)
        delete "/v1/films/#{film1.id}/planets/#{planet2.id}"
        # payload = JSON.parse(response.body)
        expect(response).to have_http_status(:no_content)
        expect(response.body).to be_empty
        expect(Film.find(film1.id).planets.size).to eq(1)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        delete "/v1/films/#{film1.id}/planets/#{planet1.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /v1/films/:id/people' do
    let!(:film1) { create(:film) }
    let!(:planet1) { create(:planet) }
    let!(:people1) { create(:people, planet_id: planet1.id) }
    let!(:people2) { create(:people, planet_id: planet1.id) }
    let!(:filmpeople1) { create(:film_people, people_id: people1.id, film_id: film1.id) }
    let!(:filmpeople2) { create(:film_people, people_id: people2.id, film_id: film1.id) }

    describe 'with auth' do
      before { sign_in user }

      it 'should list the people of the film' do
        get "/v1/films/#{film1.id}/people"
        payload = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(payload['people'].size).to eq(2)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        get "/v1/films/#{film1.id}/people"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /v1/films/:id/people' do
    let!(:planet) { create(:planet) }
    let!(:film) { create(:film) }
    let!(:people) { create(:people, planet_id: planet.id) }

    describe 'with auth' do
      before { sign_in user }

      it 'should create the people for the film' do
        post "/v1/films/#{film.id}/people", params: { people: { id: people.id } }
        payload = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(payload['people'].size).to eq(1)
        expect(Film.find(film.id).people.size).to eq(1)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        post "/v1/films/#{film.id}/people", params: { people: { id: people.id } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE  /v1/films/:film_id/people/:people_id' do
    let!(:film1) { create(:film) }
    let!(:planet1) { create(:planet) }
    let!(:people1) { create(:people, planet_id: planet1.id) }
    let!(:people2) { create(:people, planet_id: planet1.id) }
    let!(:filmpeople1) { create(:film_people, people_id: people1.id, film_id: film1.id) }
    let!(:filmpeople2) { create(:film_people, people_id: people2.id, film_id: film1.id) }

    describe 'with auth' do
      before { sign_in user }

      it 'should delete the people for the film' do
        expect(Film.find(film1.id).people.size).to eq(2)
        delete "/v1/films/#{film1.id}/people/#{people2.id}"
        # payload = JSON.parse(response.body)
        expect(response).to have_http_status(:no_content)
        expect(response.body).to be_empty
        expect(Film.find(film1.id).people.size).to eq(1)
      end
    end

    describe 'without auth' do
      it 'should return an error' do
        delete "/v1/films/#{film1.id}/people/#{people1.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
