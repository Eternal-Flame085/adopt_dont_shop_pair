require 'rails_helper'

describe 'As a visitor' do
  describe 'In the shelter Index page I see a link for New Shelter' do
    describe 'The link takes me to /shelters/new' do

      it 'I see a form for a new shelter' do
        visit '/shelters/new'
        expect(page).to have_content("Shelter Info")
        fill_in 'shelter[name]', with:'Safe Heaven'
        fill_in 'shelter[address]', with:'87236'
        fill_in 'shelter[city]', with:'Heaven'
        fill_in 'shelter[state]', with:'CA'
        fill_in 'shelter[zip]', with:'324'

        click_button 'Create shelter'
        expect(current_path).to eq('/shelters')

        expect(page).to have_content('Safe Heaven')
        expect(page).to have_content('87236')
        expect(page).to have_content('Heaven')
        expect(page).to have_content('CA')
        expect(page).to have_content('324')
      end
    end
  end
end
