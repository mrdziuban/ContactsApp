class FavoritesController < ApplicationController
  before_filter :authenticate

  def index
    render json: current_user.favorites
  end

  def create
    favorite = current_user.favorites.build(contact_id: params[:contact_id])

    if favorite.save
      render json: favorite
    else
      render json: favorite.errors, status: :unprocessable_entity
    end
  end

  # Needs a failing error code
  def destroy
    favorite = Favorite.find(params[:id])

    if favorite.user_id == current_user.id
      favorite.destroy
      render text: "deleted"
    else
      render text: "You can't delete that favorite!"
    end
  end
end
