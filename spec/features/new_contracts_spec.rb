require 'rails_helper'

RSpec.feature "New Contracts", type: :feature do
  let(:user) { create(:user) }

  scenario 'User is not signed in' do
    visit '/contracts/new'

    expect(page).to have_current_path(signin_path)
  end

  describe 'User is signed in' do
    let!(:vodafone) { create(:vendor, name: 'Vodafone') }
    let!(:o2) { create(:vendor, name: 'O2') }
    let!(:vattenfall) { create(:vendor, name: 'Vattenfall') }

    let!(:internet) { create(:category, name: 'Internet') }
    let!(:phone) { create(:category, name: 'Phone') }
    let!(:mobile_phone) { create(:category, name: 'Mobile Phone') }
    let!(:dsl) { create(:category, name: 'DSL') }
    let!(:electricity) { create(:category, name: 'Electricity') }
    let!(:gas) { create(:category, name: 'Gas') }

    before do
      vodafone.categories = [internet, phone, mobile_phone, dsl]
      o2.categories = [interne, dsl]
      vattenfall.categories = [internet, electricity, gas]
    end

    before do
      login_as(user, :scope => :user)
      visit '/contracts/new'
    end

    scenario 'Create contract with valid informations' do
      find('select#vendor').find("option[value='#{vodafone.id}'").select_option
    end
  end
end
