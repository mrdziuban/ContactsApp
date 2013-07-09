class UsersController < ApplicationController
  before_filter :authenticate, except: [:create,:index,:show]

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
    user = current_user.update_attributes(params[:user])

    if user
      render text: "Update successful"
    else
      render json: user.errors, status: :not_acceptable
    end
  end

  # Error catches

  def destroy
    user = current_user.destroy
    render text: "deleted"
  end
end
