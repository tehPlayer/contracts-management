require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  scenario 'Users fill form with valid information' do
    visit '/signup'

    fill_in 'Full Name', with: 'John Doe'
    fill_in 'Email', with: "john.doe@gmail.com"
    fill_in 'Password', with: '12345678'
    fill_in 'Password Confirmation', with: '12345678'
    expect{
      click_button 'Sign Up'
    }.to change(User, :count).by(1)

    # expect(page).to have_current_path('/contracts')
    expect(page).to have_current_path(root_path)
  end

  scenario 'Full Name is empty' do
    visit '/signup'

    fill_in 'Full Name', with: ''
    fill_in 'Email', with: "john.doe@gmail.com"
    fill_in 'Password', with: '12345678'
    fill_in 'Password Confirmation', with: '12345678'
    expect{
      click_button 'Sign Up'
    }.to_not change(User, :count)

    expect(page).to have_text('Full Name can\'t be blank')
    expect(page).to have_current_path(signup_path)
  end

  scenario 'Email is empty' do
    visit '/signup'

    fill_in 'Full Name', with: 'John Doe'
    fill_in 'Email', with: ''
    fill_in 'Password', with: '12345678'
    fill_in 'Password Confirmation', with: '12345678'
    expect{
      click_button 'Sign Up'
    }.to_not change(User, :count)

    expect(page).to have_text('Email can\'t be blank')
    expect(page).to have_current_path(signup_path)
  end

  scenario 'Email is invalid' do
    visit '/signup'

    fill_in 'Full Name', with: 'John Doe'
    fill_in 'Email', with: 'john#doe.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password Confirmation', with: '12345678'
    expect{
      click_button 'Sign Up'
    }.to_not change(User, :count)

    expect(page).to have_text('Email is invalid')
    expect(page).to have_current_path(signup_path)
  end

  scenario 'The Email is already taken' do
    create(:user, email: 'john.doe@gmail.com')
    visit '/signup'

    fill_in 'Full Name', with: 'John Doe'
    fill_in 'Email', with: 'john.doe@gmail.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password Confirmation', with: '12345678'
    expect{
      click_button 'Sign Up'
    }.to_not change(User, :count)

    expect(page).to have_text('This email is already taken')
    expect(page).to have_current_path(signup_path)
  end

  scenario 'The password is empty' do
    visit '/signup'

    fill_in 'Full Name', with: 'John Doe'
    fill_in 'Email', with: 'john.doe@gmail.com'
    fill_in 'Password', with: ''
    fill_in 'Password Confirmation', with: '12345678'
    expect{
      click_button 'Sign Up'
    }.to_not change(User, :count)

    expect(page).to have_text('Password can\'t be blank')
    expect(page).to have_current_path(signup_path)
  end

  scenario 'The password is too short' do
    visit '/signup'

    fill_in 'Full Name', with: 'John Doe'
    fill_in 'Email', with: 'john.doe@gmail.com'
    fill_in 'Password', with: '1234567'
    fill_in 'Password Confirmation', with: '1234567'
    expect{
      click_button 'Sign Up'
    }.to_not change(User, :count)

    expect(page).to have_text('The password is too short')
    expect(page).to have_current_path(signup_path)
  end

  scenario 'Users fill form with a password confirmation that doesn\'t match' do
    visit '/signup'

    fill_in 'Full Name', with: 'John Doe'
    fill_in 'Email', with: 'john.doe@gmail.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password Confirmation', with: '12345671'
    expect{
      click_button 'Sign Up'
    }.to_not change(User, :count)

    expect(page).to have_text('The password confirmation doesn\'t match')
    expect(page).to have_current_path(signup_path)
  end

end