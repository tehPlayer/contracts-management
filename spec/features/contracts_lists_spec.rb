require 'rails_helper'

RSpec.feature "ContractsLists", type: :feature do
  scenario 'User is not signed in' do
    visit '/contracts'

    expect(page).to have_current_path(signin_path)
  end

  describe 'User is signed in' do
    let(:user) { create(:user) }

    before do
      login_as(user, :scope => :user)
    end

    scenario 'User has no contracts' do
      visit '/contracts'

      expect(page).to(
        have_text('No contracts yet. Click on the "Add Contract" button to create your first contract')
      )
      expect(page).to have_selector(:link_or_button, 'Add Contract')
    end
  end
end
