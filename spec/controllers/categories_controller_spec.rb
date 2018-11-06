require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "GET #index" do
    let!(:user) { create(:user) }
    let!(:vendor) { create(:vendor) }
    let!(:other_vendor) { create(:vendor) }
    let!(:other_categories) { create_list(:category, 3) }
    let!(:categories) { other_categories.sample(2) }

    before do
      sign_in user
    end

    it "returns empty categories, if there is none categories linked to vendor" do
      get :index, params: {vendor_id: vendor.id}
      expect(response_json).to eq([])
    end

    context 'for linked categories' do
      before do
        vendor.categories = categories
        other_vendor.categories = other_categories
      end

      it 'returns these categories, which belong to certain vendor' do
        get :index, params: {vendor_id: vendor.id}
        expect(response_json.map{|x| x['id']}).to contain_exactly(*categories.map(&:id))
      end
    end
  end

end
