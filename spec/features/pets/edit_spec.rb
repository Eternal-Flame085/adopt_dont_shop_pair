require 'rails_helper'

describe 'As a visitor' do
  describe 'When i visit /pets/:id/edit' do
    it 'should have a header with name' do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
      pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                         name: 'Max',
                         age: '3',
                         sex: 'male',
                         description: 'test',
                         status: 'Adoptable',
                         shelter_id: "#{shelter_1.id}")

      visit "/pets/#{pet_1.id}/edit"
      expect(page).to have_content("Update pet: #{pet_1.name}")
    end

    it 'Should have a form with the info to edit' do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
      pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                         name: 'Max',
                         age: '3',
                         sex: 'male',
                         description: 'test',
                         status: 'Adoptable',
                         shelter_id: "#{shelter_1.id}")

      visit "/pets/#{pet_1.id}/edit"
      fill_in 'name', with: "Subaru"
      fill_in 'description', with: "Fluffy"

      click_button 'Update Pet'
      expect(current_path).to eq("/pets/#{pet_1.id}")

      expect(page).to have_content("Name: Subaru")
      expect(page).to have_content("Age: #{pet_1.age}")
      expect(page).to have_content("Sex: #{pet_1.sex}")
      expect(page).to have_content("Status: #{pet_1.status}")
      expect(page).to have_content("Description: Fluffy")
    end
  end
end
