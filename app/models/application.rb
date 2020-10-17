class Application < ApplicationRecord
  belongs_to :user
  has_many :pets_applications
  has_many :pets, through: :pets_applications

end
