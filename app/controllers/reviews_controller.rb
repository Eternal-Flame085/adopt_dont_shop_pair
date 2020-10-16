class ReviewsController < ApplicationController

  def new

  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def delete
    Review.destroy(params[:review_id])

    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)

    redirect_to("/shelters/#{params[:shelter_id]}")
  end

  def create
    user = User.find_by(name: params[:user_name])
    if user.nil?
      flash[:notice] = "Review not created: User could not be found."
      render :new
    else
      review = Review.new({
        title: params[:title],
        rating: params[:rating],
        content: params[:content],
        photo: params[:photo],
        shelter_id: params[:shelter_id],
        user_id: user.id
      })
      if review.save
        redirect_to "/shelters/#{params[:shelter_id]}"
      else
        flash[:notice] = "Review not created: Title, Rating, and/or Content is missing."
        render :new
      end
    end
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :photo)
  end

  def review_id
    params.permit(:review_id)
  end
end
