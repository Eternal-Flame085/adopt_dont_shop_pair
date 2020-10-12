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

    describe 'I can see a link to esit the shelter' do
      it 'I am taken to /shelters/:id/edit' do
        shelter_1 = Shelter.create(name: 'AOA', address: '6254', city: 'Miami', state: 'CH', zip: '636')

        visit '/shelters'
        expect(page).to have_link(nil, href: "/shelters/#{shelter_1.id}/edit")
      end
    end
  end
end
