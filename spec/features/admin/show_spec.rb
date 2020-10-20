require 'rails_helper'

describe 'As a visitor(admin)' do
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

  describe 'When I visit an admin appllication show page "/admin/applications/:id"' do
    it "Every pet has a button to approve and reject that pet" do
      visit "/admin/applications/#{@application_1.id}"

      within(id="#pet-#{@pet_1.id}") do
        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')
      end

      within(id="#pet-#{@pet_2.id}") do
        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')
      end
    end

    it "when i click on approve i am taken  back to the admin page and
    the approved button for the pet is gone" do
      visit "/admin/applications/#{@application_1.id}"

      within(id="#pet-#{@pet_1.id}") do
        click_button 'Approve'
      end

      within(id="#pet-#{@pet_1.id}") do
        expect(page).to have_no_button('Approve')
        expect(page).to have_content('Approved')
      end

      within(id="#pet-#{@pet_2.id}") do
        expect(page).to have_button('Approve')
      end
    end

    it "When I click on reject i am taken  back to the admin page and
    the reject button for the pet is gone" do
      visit "/admin/applications/#{@application_1.id}"

      within(id="#pet-#{@pet_1.id}") do
        click_button 'Reject'
      end

      within(id="#pet-#{@pet_1.id}") do
        expect(page).to have_no_button('Reject')
        expect(page).to have_content('Rejected')
      end

      within(id="#pet-#{@pet_2.id}") do
        expect(page).to have_button('Reject')
      end
    end
  end
end
