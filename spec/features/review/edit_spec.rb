require "rails_helper"

describe 'edit a shelter review' do
  it 'can click on the link and be taken to an edit shelter page where ' do
    shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                               city: 'Miami', state: 'CH', zip: '636')
    user_1 = User.create(name: 'AOA',
                         address: '6254',
                         city: 'Miami',
                         state: 'CH',
                         zip: '636')
    review_1 = Review.create(title: 'AOA', rating: '6254',
                              content: 'Miami', photo: 'CH', user_name: '636', shelter_id: "#{shelter_1.id}",
                              user_id: "#{user_1.id}")

    visit "/shelters/#{shelter_1.id}"
    
    within(id="#review-#{review_1.id}") do
      click_link 'Edit Review'
    end

    expect(page).to have_selector('form')
    expect(page).to have_content('Title:')
    expect(page).to have_content('Rating:')
    expect(page).to have_content('Content:')
    expect(page).to have_content('User name:')
    expect(page).to have_content('Photo:')
  end

  it 'can click on the link and be taken to an edit shelter page where ' do
    shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                               city: 'Miami', state: 'CH', zip: '636')
    user_1 = User.create(name: 'AOA',
                         address: '6254',
                         city: 'Miami',
                         state: 'CH',
                         zip: '636')
    review_1 = Review.create(title: 'AOA', rating: '6254',
                              content: 'Miami', photo: 'CH', user_name: '636', shelter_id: "#{shelter_1.id}",
                              user_id: "#{user_1.id}")

    visit "/shelters/#{shelter_1.id}/#{review_1.id}/edit_review"

    expect(page).to have_field('title')
    expect(page).to have_field('rating')
    expect(page).to have_field('content')
    expect(page).to have_field('user_name')
    expect(page).to have_field('photo')

    fill_in 'title', with: "Subaru"

    click_button 'Edit Review'

    within("#review-#{review_1.id}") do
      expect(page).to have_content('Subaru')
    end
  end
end
