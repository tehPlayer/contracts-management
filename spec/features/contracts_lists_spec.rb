require 'rails_helper'

RSpec.feature "Contracts lists", type: :feature, js: true do
  let(:user) { create(:user) }

  scenario 'User is not signed in' do
    visit '/contracts'

    expect(page).to have_current_path(signin_path)
  end

  describe 'User is signed in, but has no contracts' do
    before do
      login_as(user, :scope => :user)
      visit '/contracts'
    end

    scenario 'sees a message' do
      expect(page).to(
        have_text('No contracts yet. Click on the "Add Contract" button to create your first contract')
      )
      expect(page).to have_selector(:link_or_button, 'Add Contract')
    end
    
    scenario 'Create a new contract' do
      click_on 'Add Contract'

      expect(page).to have_current_path('/contracts/new')
    end
  end
  describe 'User is signed in and has contracts' do
    let!(:contract) { create(:contract, user: user) }

    before do
      login_as(user, :scope => :user)
      visit '/contracts'
    end

    scenario 'User has contracts' do
      expect(page).to(
        have_text(['Vendor name', 'Category', 'Costs', 'Ends on'].join(' '))
      )
      expect(page).to(
        have_text([contract.vendor_name, contract.category_name].join(' '))
      )
      expect(page).to(
        have_text("$ #{'%.2f' % contract.costs}")
      )
      expect(page).to(
        have_text(contract.ends_on.strftime('%b %-d, %Y'))
      )
      expect(page).to have_selector(:link_or_button, 'Add Contract')
    end

    scenario 'Create a new contract' do
      click_on 'Add Contract'

      expect(page).to have_current_path('/contracts/new')
    end

    xscenario 'Edit an existing contract' do
      click_on 'Add Contract'

      expect(page).to have_current_path('/contracts/new')
    end
  end
end
