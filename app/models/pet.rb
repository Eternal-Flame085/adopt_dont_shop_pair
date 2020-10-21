class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pets_applications
  has_many :applications, through: :pets_applications

  def self.search(search)
    if search
      self.where("name ILIKE ?", "%#{search}%")
    else
      []
    end
  end
end
