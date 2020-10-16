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
      user_1 = User.create(name: 'Mike Dao',
                           address: '6254',
                           city: 'Miami',
                           state: 'CH',
                           zip: '636')
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                  city: 'Miami', state: 'CH', zip: '636')
      visit "/shelters/#{shelter_1.id}"
      click_link 'New Review'

      fill_in 'title', with: 'Test'
      fill_in 'rating', with: '4'
      fill_in 'content', with: 'f'
      fill_in 'user_name', with: "#{user_1.name}"
      fill_in 'photo', with: 'w'

      click_button 'Create Review'
      expect(current_path).to eq("/shelters/#{shelter_1.id}")

      expect(page).to have_content('Test')
      expect(page).to have_content('4')
      expect(page).to have_content('f')
      expect(page).to have_content("#{user_1.name}")
      expect(page).to have_content('w')
    end

    it 'can fail to enter required content and be returned to new review page with a flash message' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                                 city: 'Miami', state: 'CH', zip: '636')
      user_1 = User.create(name: 'Mike Dao',
                           address: '6254',
                           city: 'Miami',
                           state: 'CH',
                           zip: '636')
      visit "/shelters/#{shelter_1.id}/new_review"

      fill_in 'user_name', with: "#{user_1.name}"

      click_button 'Create Review'

      expect(page).to have_content("Review not created: Title, Rating, and/or Content is missing.")
      expect(page).to have_button('Create Review')
    end

    it 'can fail to enter existing user and be returned to new review page with a flash message' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                                 city: 'Miami', state: 'CH', zip: '636')
      user_1 = User.create(name: 'Mike Dao',
                           address: '6254',
                           city: 'Miami',
                           state: 'CH',
                           zip: '636')
      visit "/shelters/#{shelter_1.id}/new_review"

      click_button 'Create Review'

      expect(page).to have_content("Review not created: User could not be found.")
      expect(page).to have_button('Create Review')
    end
  end
end
