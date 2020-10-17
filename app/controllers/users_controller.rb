class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = Review.where("user_id = #{@user.id} ")
    best_rating = Review.best_rating(@reviews)
    worst_rating = Review.worst_rating(@reviews)
    @highlighted_reviews = []

    if !best_rating.nil? || !worst_rating.nil?
      @highlighted_reviews << best_rating
      @highlighted_reviews << worst_rating
    end
  end

  def create
    user = User.new({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip]
    })

    user.save

    redirect_to "/users/#{user.id}"
  end

  def new

  end
end
