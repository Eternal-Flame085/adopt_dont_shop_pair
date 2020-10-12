require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id/pets' do
    it "Should have a link to create a new pet" do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
      visit "/shelters/#{shelter_1.id}/pets"
      expect(page).to have_link('Create Pet')

      click_link 'Create Pet'
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")
    end

    describe 'When I visit /shelters/:id/pets/new' do
      it 'Should have header' do
        shelter_1 = Shelter.create(name: 'AOA',
                                   address: '6254',
                                   city: 'Miami',
                                   state: 'CH',
                                   zip: '636')
        visit "/shelters/#{shelter_1.id}/pets/new"
        expect(page).to have_content("Create new adoptable pet")
      end
    end

    it 'Should have a form for a new pet' do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
      visit "/shelters/#{shelter_1.id}/pets/new"

      fill_in 'pet[image]', with: "https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg"
      fill_in 'pet[name]', with: 'Jeremy'
      fill_in 'pet[age]', with: '3'
      fill_in 'pet[description]', with: 'Cute'
      fill_in 'pet[sex]', with: 'Male'

      click_button 'Create Pet'
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

      expected_image = 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg'
      expect(page).to have_xpath("//img[contains(@src,'#{expected_image}')]")
      expect(page).to have_content('Jeremy')
      expect(page).to have_content('3')
      expect(page).to have_content('Male')
    end
  end
end
