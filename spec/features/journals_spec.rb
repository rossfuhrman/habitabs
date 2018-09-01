require 'spec_helper'

feature 'journal' do
  before :each do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end

  scenario 'adding journal entry' do

    click_link 'New Journal Entry', match: :first

    expect(page).to have_content 'Journal Entry For:'
    
    fill_in 'journal_entry', with: 'a journal entry'
    click_button 'Save'

    expect(page).to have_content 'Journal was successfully created.'
    expect(page).to have_content 'a journal entry'

    visit root_path
    expect(page).to have_css('.show-for-medium-up a[title="Edit Journal Entry"]', count: 1)
  end

  #see the corresponding controller test
  #scenario 'deleting journal entry'

  scenario 'editing journal entry' do
    other_users_journal = FactoryGirl.create(:other_users_journal)

    users_journal = FactoryGirl.create(:journal)

    expect{
      visit edit_journal_path(other_users_journal)
    }.to raise_error ActiveRecord::RecordNotFound

    
    visit edit_journal_path(users_journal)
    fill_in 'journal_entry', with: 'New Updated Journal Entry'
    click_button 'Save'
    expect(page).to have_content 'New Updated Journal Entry'
  end
end
