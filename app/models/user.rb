class User < ApplicationRecord
has_many :reviews

def average_rating
  self.reviews.average(:rating)
end


end
