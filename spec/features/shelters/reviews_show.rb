require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit /shelters/:id' do
    it 'can see shelter reviews from show page' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                  city: 'Miami', state: 'CH', zip: '636')
      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content("Rating: ")
      expect(page).to have_content("Content:")
      expect(page).to have_content("Picture:")
      expect(page).to have_content("User name: ")
    end
    end
  end
end
