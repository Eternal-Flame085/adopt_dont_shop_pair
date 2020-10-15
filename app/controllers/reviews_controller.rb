class ReviewsController < ApplicationController

  def new

  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)

    redirect_to("/shelters/#{params[:shelter_id]}")
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

  private

  def review_params
    params.permit(:title, :rating, :content, :photo, :user_name)
  end

  def review_id
    params.permit(:review_id)
  end
end
