require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id/pets' do
    it 'Shows all the pets in that shelter' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                  city: 'Miami', state: 'CH', zip: '636')
      pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                  name: 'Max', age: '3', sex: 'male', description: 'test',
                  status: 'Adoptable', shelter_id: "#{shelter_1.id}")
      visit "/shelters/#{shelter_1.id}/pets"

      expect(page).to have_content("All #{Pet.count} pets at #{shelter_1.name}:")
      expect(page).to have_link('Create Pet')
      expect(page).to have_xpath("//img[contains(@src,'#{pet_1.image}')]")
      expect(page).to have_link("Name: #{pet_1.name}")
      expect(page).to have_content("Age: #{pet_1.age}")
      expect(page).to have_content("Sex: #{pet_1.sex}")
    end
  end
end
