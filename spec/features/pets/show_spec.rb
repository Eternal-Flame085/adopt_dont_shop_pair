require 'rails_helper'

describe 'As a visitor' do
  describe 'I see a single pet' do
    it 'should have a header' do
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

      visit "/pets/#{pet_1.id}"
      expect(page).to have_content("Name: #{pet_1.name}")
    end

    it 'Should have a picture for the pet' do
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

      visit "/pets/#{pet_1.id}"
      expect(page).to have_xpath("//img[contains(@src,'#{pet_1.image}')]")
    end

    it 'should have the pets info' do
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

      visit "/pets/#{pet_1.id}"
      expect(page).to have_content("Age: #{pet_1.age}")
      expect(page).to have_content("Sex: #{pet_1.sex}")
      expect(page).to have_content("Status: #{pet_1.status}")
      expect(page).to have_content("Description: #{pet_1.description}")
    end

    describe 'should have 2 links one to update and one to delete' do
      it 'Should have a link to update' do
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

        visit "/pets/#{pet_1.id}"
        expect(page).to have_link("Update Pet")
        click_link("Update Pet")
        expect(current_path).to eq("/pets/#{pet_1.id}/edit")
      end

      it "Should have link to delete" do
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

        visit "/pets/#{pet_1.id}"
        expect(page).to have_link("Delete Pet")
        click_link("Delete Pet")
        expect(current_path).to eq("/pets")
      end
    end
  end
end
