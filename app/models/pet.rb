class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pets_applications

  def self.search(search)
    if search
      self.where(name: search)
    else
      []
    end
  end
end
