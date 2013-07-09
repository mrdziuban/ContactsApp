class FavoritesController < ApplicationController
  # Show contact values for user's favorites
  def index
    user = User.find(params[:user_id])
    favorites = user.favorites
    render json: favorites
  end

  def create
    user = User.find(params[:user_id])
    favorite = user.favorites.build(contact_id: params[:contact_id])

    if favorite.save
      render json: favorite
    else
      render json: favorite.errors, status: :unprocessable_entity
    end
  end

  # Needs a failing error code
  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy

    render text: "deleted"
  end
end
