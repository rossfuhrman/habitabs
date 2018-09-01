require 'spec_helper'

feature 'measured habits' do
  before :each do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end

  #this is done through the Habit#create action
  #scenario 'adding measured habits'

  
  #see the corresponding controller test
  #scenario 'deleting measured habits'

  scenario 'editing measured habit' do
    other_users_measured_habit = FactoryGirl.create(:other_users_measured_habit)
    users_measured_habit = FactoryGirl.create(:measured_habit)

    expect{
      visit edit_measured_habit_path(other_users_measured_habit)
    }.to raise_error ActiveRecord::RecordNotFound 

    
    visit edit_measured_habit_path(users_measured_habit)
    fill_in 'Title', with: 'New Updated Text'
    click_button 'Save'
    expect(page).to have_content 'New Updated Text'
  end
end
