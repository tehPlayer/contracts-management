require 'rails_helper'

RSpec.feature 'Sign in', type: :feature do
  let(:password) { '12345678' }
  let(:user) do
    create(
      :user,
      email: 'john.doe@gmail.com',
      full_name: 'John Doe',
      password: password,
      password_confirmation: password
    )
  end

  scenario 'Users fill form with valid information' do
    visit '/signin'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: password

    click_button 'Sign In'

    expect(page).to have_text('Welcome back, John')
    # expect(page).to have_current_path(contracts_path)
    expect(page).to have_current_path(root_path)
  end

  scenario 'Users fill form with an email that doesn\'t match' do
    visit '/signin'

    fill_in 'Email', with: 'john.doe@outlook.com'
    fill_in 'Password', with: password

    click_button 'Sign In'

    expect(page).to have_text('We weren\'t able to find a user with the specified email and password combination')
    expect(page).to have_current_path(signin_path)
  end

  scenario 'Users fill form with a password that doesn\'t match' do
    visit '/signin'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: '1234567'

    click_button 'Sign In'

    expect(page).to have_text('We weren\'t able to find a user with the specified email and password combination')
    expect(page).to have_current_path(signin_path)
  end
end
