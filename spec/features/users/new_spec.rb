require "rails_helper"

describe 'As a visitor' do
  describe 'When I visit /users/new' do
    it 'I see form lables' do
      visit '/users/new'
      expect(page).to have_selector('form')
      expect(page).to have_content('Name:')
      expect(page).to have_content('Address:')
      expect(page).to have_content('City:')
      expect(page).to have_content('State:')
      expect(page).to have_content('Zip:')
    end

    it 'I see form fields' do
      visit '/users/new'
      expect(page).to have_field('name')
      expect(page).to have_field('address')
      expect(page).to have_field('city')
      expect(page).to have_field('state')
      expect(page).to have_field('zip')
    end

    it 'it can submit form' do
      visit '/users/new'

      fill_in 'name', with: 'Mike Dao'
      fill_in 'address', with:'82347'
      fill_in 'city', with: 'fdwd'
      fill_in 'state', with: 'dwf'
      fill_in 'zip', with: '7218'

      click_button 'Create User'

      expect(page).to have_content('Name: Mike Dao')
      expect(page).to have_content('Address: 82347')
      expect(page).to have_content('City: fdwd')
      expect(page).to have_content('State: dwf')
      expect(page).to have_content('Zip: 7218')
    end
  end
end
