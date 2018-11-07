require 'rails_helper'

RSpec.describe ContractsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    let(:vendor) { create(:vendor) }
    let(:category) { create(:category) }

    let(:params) do
      {
        contract: {
          vendor_id: vendor.id,
          category_id: category.id,
          costs: '10.5',
          ends_on: '2018-13-01'
        }
      }
    end

    before do
      vendor.categories = [category]
    end

    it 'Won\'t create a contract with an invalid ends on' do
      expect { post :create, params: params }.to_not change(Contract, :count)
      expect(response).to_not have_http_status(:redirect)
      expect(flash[:alert]).to include('Ends On is invalid')
    end
  end

  describe 'PUT #update' do
    let(:vendor) { create(:vendor) }
    let(:category) { create(:category) }
    let(:contract) do
      create(:contract, vendor: vendor, category: category, user: user, ends_on: Date.tomorrow)
    end

    let(:params) do
      {
        contract: {
          vendor_id: contract.vendor_id,
          category_id: contract.category_id,
          costs: contract.costs,
          ends_on: '2018-13-01'
        },
        id: contract.id
      }
    end

    before do
      vendor.categories = [category]
    end

    it 'Won\'t update a contract with an invalid ends on' do
      put :update, params: params
      expect(contract.reload.ends_on).to eq(Date.tomorrow)
      expect(response).to_not have_http_status(:redirect)
      expect(flash[:alert]).to include('Ends On is invalid')
    end
  end
end
