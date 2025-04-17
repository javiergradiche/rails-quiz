require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let(:valid_attributes) { { name: 'Test Company' } }
  let(:invalid_attributes) { { name: '' } }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    context 'with valid parameters' do
      it 'creates a new Company' do
        expect {
          post :create, params: { company: valid_attributes }
        }.to change(Company, :count).by(1)
      end

      it 'redirects to the companies list' do
        post :create, params: { company: valid_attributes }
        expect(response).to redirect_to(companies_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Company' do
        expect {
          post :create, params: { company: invalid_attributes }
        }.to change(Company, :count).by(0)
      end

      it 'renders new template with unprocessable_entity status' do
        post :create, params: { company: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT update' do
    let(:company) { Company.create!(valid_attributes) }

    context 'with valid parameters' do
      let(:new_attributes) { { name: 'Updated Company' } }

      it 'updates the requested company' do
        put :update, params: { id: company.to_param, company: new_attributes }
        company.reload
        expect(company.name).to eq('Updated Company')
      end

      it 'redirects to the companies list' do
        put :update, params: { id: company.to_param, company: new_attributes }
        expect(response).to redirect_to(companies_path)
      end
    end

    context 'with invalid parameters' do
      it 'renders edit template with unprocessable_entity status' do
        put :update, params: { id: company.to_param, company: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:company) { Company.create!(valid_attributes) }

    it 'destroys the requested company' do
      expect {
        delete :destroy, params: { id: company.to_param }
      }.to change(Company, :count).by(-1)
    end

    it 'redirects to the companies list' do
      delete :destroy, params: { id: company.to_param }
      expect(response).to redirect_to(companies_path)
    end
  end
end 