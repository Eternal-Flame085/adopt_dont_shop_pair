require 'rails_helper'

describe 'as a visitor' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'AOA',
                               address: '6254',
                               city: 'Miami',
                               state: 'CH',
                               zip: '636')
    @pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                       name: 'Max',
                       age: '3',
                       sex: 'male',
                       description: 'test',
                       status: 'Adoptable',
                       shelter_id: "#{@shelter_1.id}")
    @pet_2 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                                          name: 'Fido',
                                          age: '3',
                                          sex: 'male',
                                          description: 'test',
                                          status: 'Adoptable',
                                          shelter_id: "#{@shelter_1.id}")
    @user_1 = User.create(name: 'Mike Dao',
                          address: '6254',
                          city: 'Miami',
                          state: 'CH',
                          zip: '636')
    @application_1 = Application.create(description: "I love dogs",
                                        status: "Pending",
                                        user_id: @user_1.id)
    PetsApplication.create(pet_id: @pet_1.id, application_id: @application_1.id)
    PetsApplication.create(pet_id: @pet_2.id, application_id: @application_1.id)
  end
  describe 'application show page' do
    it 'can visit an application show page and see application information' do
      visit "applications/#{@application_1.id}"

      expect(page).to have_content(@user_1.name)
      expect(page).to have_content(@user_1.address)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content(@application_1.status)

      within(id="#pet-#{@pet_1.id}") do
        expect(page).to have_content(@pet_1.name)
      end
      within(id="#pet-#{@pet_2.id}") do
        expect(page).to have_content(@pet_2.name)
      end
    end
  end
end
