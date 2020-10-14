class ReviewsController < ApplicationController

  def new

  end

  def create
    users = User.all
    user_id = nil

    users.each do |user|
      user_id = user if user.name == params[:user_name]
    end
    review = Review.new({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      photo: params[:photo],
      user_name: params[:user_name],
      shelter_id: params[:shelter_id],
      user_id: user_id.id
    })

    review.save

    redirect_to "/shelters/#{params[:shelter_id]}"
  end
end
