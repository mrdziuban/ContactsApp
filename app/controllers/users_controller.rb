class UsersController < ApplicationController
  def index
    render :json => User.all
  end

  def create
    user = User.new(params[:user])
    if user.save
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: User.find_by_id(params[:id])
  end

  def update
    user = User.update(params[:id], params[:user])
    if user
      render json: user
    else
      render json: user.errors, status: :not_acceptable
    end
  end

  def destroy
    User.destroy(params[:id])
    render text: "deleted"
  end
end
