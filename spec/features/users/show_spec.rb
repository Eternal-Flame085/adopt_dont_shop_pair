require "rails_helper"

describe 'As a visitor' do
  describe 'when I visit a users show page' do
   it 'can see all of the users information' do
     user_1 = User.create(name: 'AOA',
                          address: '6254',
                          city: 'Miami',
                          state: 'CH',
                          zip: '636')

    visit "/users/#{user_1.id}"
    expect(page).to have_content("Name: #{user_1.name}")
    expect(page).to have_content("Address: #{user_1.address}")
    expect(page).to have_content("City: #{user_1.city}")
    expect(page).to have_content("State: #{user_1.state}")
    expet(page).to have_content("Zip: #{user_1.zip}")
    end
  end
end
