require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit /shelters/:id' do
    it 'I see the shelters information' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                  city: 'Miami', state: 'CH', zip: '636')
      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content("Address: #{shelter_1.address}")
      expect(page).to have_content("City: #{shelter_1.city}")
      expect(page).to have_content("State: #{shelter_1.state}")
      expect(page).to have_content("Zip: #{shelter_1.zip}")
    end

    it 'can see a list of reviews for the shelter' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                  city: 'Miami', state: 'CH', zip: '636')
      user_1 = User.create(name: 'AOA',
                           address: '6254',
                           city: 'Miami',
                           state: 'CH',
                           zip: '636')
      review_1 = Review.create(title: 'AOA', rating: '6254',
                  content: 'Miami', photo: 'CH', user_name: '636', shelter_id: "#{shelter_1.id}",
                  user_id: "#{user_1.id}")
          visit "/shelters/#{shelter_1.id}"


      expect(page).to have_content("Title: #{review_1.title}")
      expect(page).to have_content("Rating: #{review_1.rating}")
      expect(page).to have_content("Content: #{review_1.content}")
      expect(page).to have_content("Picture: #{review_1.photo}")
      expect(page).to have_content("User name: #{user_1.name}")
    end

    it 'Has link for new review' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                  city: 'Miami', state: 'CH', zip: '636')
      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_link('New Review')
    end

    it 'can see a link to edit the shelter review next to each review' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                                 city: 'Miami', state: 'CH', zip: '636')
      user_1 = User.create(name: 'AOA',
                           address: '6254',
                           city: 'Miami',
                           state: 'CH',
                           zip: '636')
      review_1 = Review.create(title: 'Best Ever', rating: '6254',
                                content: 'Miami', photo: 'CH', user_name: '636', shelter_id: "#{shelter_1.id}",
                                user_id: "#{user_1.id}")

      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_link('Edit Review')
    end

    it "I see a link next to each shelter review to delete the review" do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                                 city: 'Miami', state: 'CH', zip: '636')
      user_1 = User.create(name: 'AOA',
                           address: '6254',
                           city: 'Miami',
                           state: 'CH',
                           zip: '636')
      review_1 = Review.create(title: 'Best Ever', rating: '6254',
                                content: 'Miami', photo: 'CH', user_name: '636', shelter_id: "#{shelter_1.id}",
                                user_id: "#{user_1.id}")

      visit "/shelters/#{shelter_1.id}"

      within(id="#review-#{review_1.id}") do
        expect(page).to  have_link('Delete Review')
      end

      within(id="#review-#{review_1.id}") do
        expect(page).to  have_content("Title: #{review_1.title}")

        click_link "Delete Review"
      end

      expect(page).to have_no_content("#{review_1.title}")
    end

    it "Has statistics including pet count, average shelter rating, number of applications on file" do
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
                                          status: "In Progress",
                                          user_id: user_1.id)
      application_2 = Application.create(status: "In Progress",
                                          user_id: user_1.id)
      PetsApplication.create(pet_id: pet_1.id, application_id: application_1.id, status: 'Pending')
      PetsApplication.create(pet_id: pet_2.id, application_id: application_1.id, status: 'Pending')
      PetsApplication.create(pet_id: pet_3.id, application_id: application_1.id, status: 'Pending')
      PetsApplication.create(pet_id: pet_3.id, application_id: application_2.id, status: 'Approved')

      visit "/shelters/#{shelter_1.id}"

      within(id="#statistics") do
        expect(page).to have_content("Pet count: #{shelter_1.pets.count}")
      end
      reviews = [review_1, review_2]
      average = ((review_1.rating + review_2.rating)/reviews.count)

      within(id="#statistics") do
        expect(page).to have_content("Average shelter rating: #{average}")
      end

      application_count = [application_1, application_2]
      within(id="#statistics") do
        expect(page).to have_content("Number of applications: #{application_count.count}")
      end
    end
  end
end
