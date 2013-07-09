class FavoritesController < ApplicationController
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

  def destroy
    user = User.find(params[:user_id])
    favorite = user.favorites.find(params[:id])
    favorite.destroy
    render text: "deleted"
  end
end
