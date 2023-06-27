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
end
