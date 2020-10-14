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
    expect(page).to have_content("Zip: #{user_1.zip}")
    end
  it 'can see every review written by user and see the reviews title, rating, and content' do
    user_1 = User.create(name: 'AOA',
                         address: '6254',
                         city: 'Miami',
                         state: 'CH',
                         zip: '636')
    shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                               city: 'Miami', state: 'CH', zip: '636')
    review_1 = Review.create(title: 'AOA', rating: '6254',
                             content: 'Miami', photo: 'CH', user_name: '636', shelter_id: "#{shelter_1.id}",
                             user_id: "#{user_1.id}")
    visit "/users/#{user_1.id}"

    expect(page).to have_content("Title: #{review_1.title}")
    expect(page).to have_content("Rating: #{review_1.rating}")
    expect(page).to have_content("Content: #{review_1.content}")
    end
  end
end
