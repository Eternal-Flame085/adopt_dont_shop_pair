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
      expect(page).to have_content("User name: #{review_1.user_name}")
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
      review_1 = Review.create(title: 'AOA', rating: '6254',
                                content: 'Miami', photo: 'CH', user_name: '636', shelter_id: "#{shelter_1.id}",
                                user_id: "#{user_1.id}")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_link('Edit Review')
    end
  end
end
