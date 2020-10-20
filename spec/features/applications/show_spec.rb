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
                                        status: "In Progress",
                                        user_id: @user_1.id)
    @application_2 = Application.create(status: "In Progress",
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

    it 'can visit a application show page that has not been submitted and see a
    section to add a pet to the application' do
      visit "applications/#{@application_1.id}"

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_selector('form')
      expect(page).to have_field('search')
      expect(page).to have_button('Search')
    end

    it 'can fill pets name in search field, click submit, and be taken back to show page
    and see any pet name under show bar whose name matches search' do
      visit "applications/#{@application_1.id}"

      fill_in 'search', with: "#{@pet_1.name}"
      click_button 'Search'

      within(id='#pet_search') do
        expect(page).to have_content(@pet_1.name)
      end
    end

    it "next to each pet name I see a button to 'Adopt this pet'" do
      visit "applications/#{@application_1.id}"

      fill_in 'search', with: "#{@pet_1.name}"
      click_button 'Search'

      within(id='#pet_search') do
        expect(page).to have_button('Adopt this pet')
      end
    end

    it "after clicking 'Adopt this pet' I am taken back to the application show page" do
      visit "applications/#{@application_2.id}"

      fill_in 'search', with: "#{@pet_1.name}"
      click_button 'Search'
      within(id='#pet_search') do
        click_button 'Adopt this pet'
      end

      within(id="#pet-#{@pet_1.id}") do
        expect(page).to have_content(@pet_1.name)
      end
    end

    it "I see an input to enter why i make a good owener" do
      visit "applications/#{@application_2.id}"

      fill_in 'search', with: "#{@pet_1.name}"
      click_button 'Search'
      within(id='#pet_search') do
        click_button 'Adopt this pet'
      end

      within(id="#submission") do
        expect(page).to have_selector('form')
        expect(page).to have_field('description')
        expect(page).to have_button('Submit Application')
      end
    end

    it "when i click submit this application i am taken back to the
    show page and indicator is that the application  is now Pending" do
      visit "applications/#{@application_2.id}"

      fill_in 'search', with: "#{@pet_1.name}"
      click_button 'Search'
      within(id='#pet_search') do
        click_button 'Adopt this pet'
      end

      within(id="#submission") do
        fill_in 'description', with: "I like dogs"
        click_button 'Submit Application'
      end

      expect(page).to have_content("Description: I like dogs")
      expect(page).to have_content("Status: Pending")
    end

    it 'can fail to enter description and is returned to show page with flash message
    and application still in progress' do
      visit "applications/#{@application_2.id}"

      fill_in 'search', with: "#{@pet_1.name}"
      click_button 'Search'
      within(id='#pet_search') do
        click_button 'Adopt this pet'
      end

      within(id="#submission") do
        click_button 'Submit Application'
      end

      expect(page).to have_content("Please complete application description")
      expect(page).to have_content("Status: In Progress")
    end

    it "can find partial matches for pet names" do
      pet_3 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                                          name: 'Maximus',
                                          age: '3',
                                          sex: 'male',
                                          description: 'test',
                                          status: 'Adoptable',
                                          shelter_id: "#{@shelter_1.id}")
      visit "applications/#{@application_2.id}"

      fill_in 'search', with: "#{@pet_1.name}"
      click_button 'Search'
      within(id='#pet_search') do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(pet_3.name)
      end
    end

    it 'can search for pets case insensitive' do
      pet_3 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                                        name: 'maximus',
                                        age: '3',
                                        sex: 'male',
                                        description: 'test',
                                        status: 'Adoptable',
                                        shelter_id: "#{@shelter_1.id}")
      visit "applications/#{@application_2.id}"

      fill_in 'search', with: "#{@pet_1.name}"
      click_button 'Search'
      within(id='#pet_search') do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(pet_3.name)
      end
    end
  end
end
