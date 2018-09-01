require 'spec_helper'

feature 'habits' do
  before :each do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end

  scenario 'adding items to the dashboard', js: true do
    other_users_habit = FactoryGirl.create(:other_users_habit)
    other_users_measured_habit = FactoryGirl.create(:other_users_measured_habit)
    other_users_journal = FactoryGirl.create(:other_users_journal)

    #only have header and footer
    expect(page).to have_css('table tr', count: 2)

    expect(page).to have_css('a[title="Edit Journal Entry"]', count: 0)

    click_link 'Add a Habit'
    fill_in 'Title', with: 'Coffee'
    click_button 'Save'

    expect(page).to have_css('table tr', count: 3)

    click_link 'Add a Habit'
    fill_in 'Title', with: 'Weight'
    find('#extra_measurement_type').find(:xpath, 'option[2]').select_option
    click_button 'Save'

    expect(page).to have_css('table tr', count: 4)
  end

  #see the corresponding controller test
  #scenario 'deleting habits'

  scenario 'editing habit' do
    other_users_habit = FactoryGirl.create(:other_users_habit)
    users_habit = FactoryGirl.create(:habit)

    expect{
      visit edit_habit_path(other_users_habit)
    }.to raise_error ActiveRecord::RecordNotFound 

    
    visit edit_habit_path(users_habit)
    fill_in 'Title', with: 'New Updated Text'
    click_button 'Save'
    expect(page).to have_content 'New Updated Text'
  end
end
