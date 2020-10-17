class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pets_applications
end
