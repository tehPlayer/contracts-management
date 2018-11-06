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
        find('input[name="contract[costs]"]').set('10.5')
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

    scenario 'Create contract with negative costs' do
      within('form.user-form') do
        find('select[name="contract[vendor_id]"]').find("option[value='#{vodafone.id}']").select_option
        find('select[name="contract[category_id]"]').find("option[value='#{internet.id}']").select_option
        find('input[name="contract[costs]"]').set('-50.0')
        find('.react-date-picker__calendar-button').click
        within('.react-calendar__month-view__days') do
          find('.react-calendar__month-view__days__day:last-child').click
        end

        expect {
          click_on('Create')
        }.to_not change(Contract, :count)
      end

      expect(page).to have_text('The cost value is invalid')
      expect(page).to have_css('form.user-form')
    end

    scenario 'Create contract with zero costs' do
      within('form.user-form') do
        find('select[name="contract[vendor_id]"]').find("option[value='#{vodafone.id}']").select_option
        find('select[name="contract[category_id]"]').find("option[value='#{internet.id}']").select_option
        find('input[name="contract[costs]"]').set('0.0')
        find('.react-date-picker__calendar-button').click
        within('.react-calendar__month-view__days') do
          find('.react-calendar__month-view__days__day:last-child').click
        end

        expect {
          click_on('Create')
        }.to_not change(Contract, :count)
      end

      expect(page).to have_text('The cost value is invalid')
      expect(page).to have_css('form.user-form')
    end

    scenario 'Create contract with non-numerical costs' do
      within('form.user-form') do
        find('select[name="contract[vendor_id]"]').find("option[value='#{vodafone.id}']").select_option
        find('select[name="contract[category_id]"]').find("option[value='#{internet.id}']").select_option
        find('input[name="contract[costs]"]').set('fifty')
        find('.react-date-picker__calendar-button').click
        within('.react-calendar__month-view__days') do
          find('.react-calendar__month-view__days__day:last-child').click
        end

        expect {
          click_on('Create')
        }.to_not change(Contract, :count)
      end

      expect(page).to have_text('The cost value is invalid')
      expect(page).to have_css('form.user-form')
    end

    scenario 'Create a contract with an ends on date in the past' do
      within('form.user-form') do
        find('select[name="contract[vendor_id]"]').find("option[value='#{vodafone.id}']").select_option
        find('select[name="contract[category_id]"]').find("option[value='#{internet.id}']").select_option
        find('input[name="contract[costs]"]').set('10.5')
        find('.react-date-picker__calendar-button').click
        within('.react-calendar__month-view__days') do
          find('.react-calendar__month-view__days__day:first-child').click
        end

        expect {
          click_on('Create')
        }.to_not change(Contract, :count)
      end

      expect(page).to have_text('Ends On can\'t be in the past')
      expect(page).to have_css('form.user-form')
    end

    # scenario 'Create a contract with an invalid ends on'

    scenario 'Vendor is not selected' do
      within('form.user-form') do
        vendor = find('select[name="contract[vendor_id]"] option:checked').text
        category = find('select[name="contract[category_id]"] option').text

        expect(vendor).to eq('Select a vendor')
        expect(category).to eq('Select a category')
        expect(all('select[name="contract[category_id]"] option').size).to eq(1)
      end
    end

    scenario 'Viewing available vendors' do
      within('form.user-form') do
        vendors = all('select[name="contract[vendor_id]"] option:not(:checked)').map(&:text)

        expect(vendors).to contain_exactly("Vodafone", "O2", "Vattenfall")
      end
    end

    scenario 'Select Vodafone as vendor' do
      within('form.user-form') do
        find('select[name="contract[vendor_id]"]').find("option[value='#{vodafone.id}']").select_option
        categories = all('select[name="contract[category_id]"] option:not(:checked)').map(&:text)

        expect(categories).to contain_exactly("Internet", "Phone", "Mobile Phone", "DSL")
      end
    
    end

    scenario 'Select O2 as vendor' do
      within('form.user-form') do
        find('select[name="contract[vendor_id]"]').find("option[value='#{o2.id}']").select_option
        categories = all('select[name="contract[category_id]"] option:not(:checked)').map(&:text)

        expect(categories).to contain_exactly("Internet", "DSL")
      end
    
    end

    scenario 'Select Vattenfall as vendor' do
      within('form.user-form') do
        find('select[name="contract[vendor_id]"]').find("option[value='#{vattenfall.id}']").select_option
        categories = all('select[name="contract[category_id]"] option:not(:checked)').map(&:text)

        expect(categories).to contain_exactly("Internet", "Electricity", "Gas")
      end
    
    end
  end
end
