require 'rails_helper'

describe 'As a visitor' do
  describe 'When i visit /shelters/:id/edit' do
    it 'Displays a form filled in in which i can change information' do
      shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                  city: 'Miami', state: 'CH', zip: '636')

      visit "/shelters/#{shelter_1.id}/edit"
      expect(page).to have_content("Edit Shelter Info")

      fill_in 'shelter[name]', with: "Heaven"

      click_button 'Submit shelter'
      expect(current_path).to eq('/shelters')
      
      expect(page).to have_content("Heaven")
      expect(page).to have_content("#{shelter_1.address}")
      expect(page).to have_content("#{shelter_1.city}")
      expect(page).to have_content("#{shelter_1.state}")
      expect(page).to have_content("#{shelter_1.zip}")
    end
  end
end
