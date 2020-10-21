require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it { should belong_to :shelter}
  end

  describe 'instance methods' do
    it '#deletable?' do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
      pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                         name: 'Max',
                         age: '3',
                         sex: 'male',
                         description: 'test',
                         status: 'Adoptable',
                         shelter_id: "#{shelter_1.id}")
      user_1 = User.create(name: 'Mike Dao',
                            address: '6254',
                            city: 'Miami',
                            state: 'CH',
                            zip: '636')
      application_1 = Application.create(description: "I love dogs",
                                          status: "Approved",
                                          user_id: user_1.id)
      PetsApplication.create(pet_id: pet_1.id, application_id: application_1.id, status: 'Approved')
      
      expect(pet_1.deletable?).to be_in([false])
      end
    end
end
