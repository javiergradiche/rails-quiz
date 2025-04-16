require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  subject { response }
  describe 'GET index' do
    before { get :index }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'GET new' do
    before { get :new }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'POST create' do
    context 'when the record is valid' do
      let(:params) { { person: { name: 'foo', phone_number: '123', email: 'foo@email.com' } } }

      it 'Creates a record' do
        expect{ post :create, params: params }.to change{ Person.count }.by(1)
      end

      it 'has status found' do
        post :create, params: params
        expect(response).to have_http_status(:found)
      end
    end

    context 'when the record is invalid' do
      let(:params) { { person: { name: 'foo', phone_number: '123', email: 'foo' } } }

      it 'does not create a record' do
        expect{ post :create, params: params }.to change{ Person.count }.by(0)
      end

      it 'has status unprocessable_entity' do
        post :create, params: params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(assigns(:person).errors[:email]).to include("is invalid")
      end
    end
  end
end
