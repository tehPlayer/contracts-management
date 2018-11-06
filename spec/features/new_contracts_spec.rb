require 'rails_helper'

RSpec.feature "New Contracts", type: :feature, js: true do
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
      o2.categories = [internet, dsl]
      vattenfall.categories = [internet, electricity, gas]
    end

    before do
      login_as(user, :scope => :user)
      visit '/contracts/new'
    end

    scenario 'Create contract with valid informations' do
      within('form.user-form') do
        find('select[name="contract[vendor_id]"]').find("option[value='#{vodafone.id}']").select_option
        find('select[name="contract[category_id]"]').find("option[value='#{internet.id}']").select_option
        find('input[name="contract[costs]"]',).set('10.5')
        find('.react-date-picker__calendar-button').click
        within('.react-calendar__month-view__days') do
          find('.react-calendar__month-view__days__day:last-child').click
        end

        expect {
          click_on('Create')
        }.to change(Contract, :count).by(1)
      end

      expect(page).to have_text(
        ['Vodafone', 'Internet', '$ 10.50'].join(' ')
      )
      expect(page).to have_text('Your contract was added')
    end
  end
end
