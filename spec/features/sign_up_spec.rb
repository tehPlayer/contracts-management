require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  scenario 'Users fill form with valid information' do
    visit '/signup'

    fill_in 'Full Name', with: 'John Doe'
    fill_in 'Email', with: 'john.doe@gmail.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password Confirmation', with: '12345678'
    click_button 'Sign Up'

    expect(page).to have_current_path('/contracts')
  end
end