class User < ApplicationRecord
has_many :reviews
has_many :applications


def average_rating
  self.reviews.average(:rating)
end


end
