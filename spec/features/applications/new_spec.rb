require 'rails_helper'

describe 'As a visitor' do
  describe 'In pets index page I click the link "Start an Application"' do
    it "I am taken to a new application page" do
      visit '/pets'

      click_link 'Start an Application'

      expect(current_path).to eq('/applications/new')
    end

    it "has a form to fill with my user name" do
      visit '/applications/new'

      expect(page).to have_selector('form')
      expect(page).to have_css('input[type="text"]')
      expect(page).to have_button('Submit Application')
    end

    it "When i click submit application i am taken to the applications show page" do
      user = User.create(name: 'Mike Dao',
                            address: '6254',
                            city: 'Miami',
                            state: 'CH',
                            zip: '636')
      visit '/applications/new'

      fill_in 'user_name', with: 'Mike Dao'

      click_button 'Submit Application'

      expect(page).to have_content(user.name)
      expect(page).to have_content(user.address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip)
    end

    it "Flash message if user does not exist" do
      visit '/applications/new'
      click_button 'Submit Application'

      expect(page).to have_content("User could not be found")
      expect(page).to have_button("Submit Application")
    end
  end
end
