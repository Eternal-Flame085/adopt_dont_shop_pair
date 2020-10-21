require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters' do
    it 'visits /shelters and see the name of each shelter' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254', city: 'Miami', state: 'CH', zip: '636')

      visit '/shelters'
      expect(page).to have_content("All shelters in the system:")
      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_1.address)
      expect(page).to have_content(shelter_1.city)
      expect(page).to have_content(shelter_1.state)
      expect(page).to have_content(shelter_1.zip)
    end

    describe 'I see a link to create a new Shelter' do
      it "I am taken to '/shelters/new'" do
        visit '/shelters'

        expect(page).to have_selector(:css, 'a[href="/shelters/new"]')
      end
    end

    describe  'I see the name that links to the show page' do
      it 'I am taken to /shelters/:id' do
        shelter_1 = Shelter.create(name: 'AOA', address: '6254', city: 'Miami', state: 'CH', zip: '636')

        visit '/shelters'
        expect(page).to have_link(nil, href: "/shelters/#{shelter_1.id}")
      end
    end

    describe 'I can see a link to edit the shelter' do
      it 'I am taken to /shelters/:id/edit' do
        shelter_1 = Shelter.create(name: 'AOA', address: '6254', city: 'Miami', state: 'CH', zip: '636')

        visit '/shelters'
        expect(page).to have_link(nil, href: "/shelters/#{shelter_1.id}/edit")
      end
    end

    it "link to delete shelter is not visible if shelter has approved applications" do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
     shelter_2 = Shelter.create(name: 'Funzzies',
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
      pet_2 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                                            name: 'Fido',
                                            age: '3',
                                            sex: 'male',
                                            description: 'test',
                                            status: 'Adoptable',
                                            shelter_id: "#{shelter_1.id}")
      pet_3 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                                            name: 'Alex',
                                            age: '5',
                                            sex: 'male',
                                            description: 'test',
                                            status: 'Adoptable',
                                            shelter_id: "#{shelter_1.id}")
      user_1 = User.create(name: 'AOA',
                           address: '6254',
                           city: 'Miami',
                           state: 'CH',
                           zip: '636')
      review_1 = Review.create(title: 'AOA', rating: '5',
                  content: 'Miami', photo: 'CH', shelter_id: "#{shelter_1.id}",
                  user_id: "#{user_1.id}")
      review_2 = Review.create(title: 'AOA', rating: '1',
                  content: 'Miami', photo: 'CH', shelter_id: "#{shelter_1.id}",
                  user_id: "#{user_1.id}")
      application_1 = Application.create(description: "I love dogs",
                                          status: "Approved",
                                          user_id: user_1.id)
      application_2 = Application.create(status: "Pending",
                                          user_id: user_1.id)
      PetsApplication.create(pet_id: pet_1.id, application_id: application_1.id, status: 'Pending')
      PetsApplication.create(pet_id: pet_2.id, application_id: application_1.id, status: 'Pending')
      PetsApplication.create(pet_id: pet_3.id, application_id: application_1.id, status: 'Pending')
      PetsApplication.create(pet_id: pet_3.id, application_id: application_2.id, status: 'Approved')
      visit '/shelters'

      within(id="#shelter-#{shelter_1.id}") do
        expect(page).to have_no_link('Delete')
      end
    end
  end
end
