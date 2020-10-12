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
  end
end
