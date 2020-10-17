require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should have_many :reviews}
  end

describe 'instance methods' do
  it '#avg_review' do
    user_1 = User.create(name: 'Mike Dao',
                         address: '6254',
                         city: 'Miami',
                         state: 'CH',
                         zip: '636')
    shelter_1 = Shelter.create(name: 'AOA', address: '6254',
                               city: 'Miami', state: 'CH', zip: '636')
    shelter_2 = Shelter.create(name: 'Denver', address: '6254',
                               city: 'Miami', state: 'CH', zip: '636')
    review_1 = Review.create(title: 'Great', rating: 10,
                             content: 'Miami', photo: 'CH', user_name: '636', shelter_id: "#{shelter_1.id}",
                             user_id: "#{user_1.id}")
    review_2 = Review.create(title: 'Bad', rating: 5,
                             content: 'Miami', photo: 'CH', user_name: '636', shelter_id: "#{shelter_2.id}",
                             user_id: "#{user_1.id}")

    expect(user_1.average_rating.round(1)).to eq(7.5)
    end
  end
end
