# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
                                    status: "Pending",
                                    user_id: @user_1.id)
PetsApplication.create(pet_id: @pet_1.id, application_id: @application_1.id)
PetsApplication.create(pet_id: @pet_2.id, application_id: @application_1.id)
