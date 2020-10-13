class ReviewsController < ApplicationRecord

  def create
    require "pry"; binding.pry
    shelter = Shelter.find(params[:id])
    review = shelter.reviews.create({
      title: params[:review][:title],
      rating: params[:review][:rating],
      content: params[:review][:content],
      photo: params[:review][:photo],
      user_name: params[:review][:user_name]
    })

    review.save

    redirect_to "/shelters/#{shelter.id}"
  end
end
