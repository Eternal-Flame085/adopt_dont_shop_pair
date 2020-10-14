require 'rails_helper'

describe 'As a visitor' do
  describe 'I click a link and i am taken to a new page to create a review' do
    it 'Has form lables' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                  city: 'Miami', state: 'CH', zip: '636')
      visit "/shelters/#{shelter_1.id}"
      click_link 'New Review'

      expect(current_path).to eq("/shelters/#{shelter_1.id}/new_review")

      expect(page).to have_selector('form')
      expect(page).to have_content('Title:')
      expect(page).to have_content('Rating:')
      expect(page).to have_content('Content:')
      expect(page).to have_content('User name:')
      expect(page).to have_content('Photo:')
    end

    it 'Has field tags' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                  city: 'Miami', state: 'CH', zip: '636')
      visit "/shelters/#{shelter_1.id}"
      click_link 'New Review'

      expect(page).to have_field('title')
      expect(page).to have_field('rating')
      expect(page).to have_field('content')
      expect(page).to have_field('user_name')
      expect(page).to have_field('photo')
    end

    it 'can submit the new review' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                  city: 'Miami', state: 'CH', zip: '636')
      visit "/shelters/#{shelter_1.id}"
      click_link 'New Review'

      fill_in 'title', with: 'Test'
      fill_in 'rating', with: '4'
      fill_in 'content', with: 'f'
      fill_in 'user_name', with: 'w'
      fill_in 'photo', with: 'w'

      click_button 'Create Review'
      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      
      expect(page).to have_content('Test')
      expect(page).to have_content('4')
      expect(page).to have_content('f')
      expect(page).to have_content('w')
      expect(page).to have_content('w')
    end
  end
end
