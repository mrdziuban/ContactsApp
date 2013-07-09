class ContactsController < ApplicationController
  def create
    # params[:user_id] is associated user_id
    user = User.find(params[:user_id])
    contact = user.contacts.build(params[:contact])

    if contact.save
      render json: contact
    else
      render json: contact.errors, status: :unprocessable_entity
    end
  end

  def index
    user = User.find(params[:user_id])
    render :json => user.contacts
  end

  def update
    user = User.find(params[:user_id])
    contact = user.contacts.find(params[:id])
    contact.update_attributes(params[:contact])

    render json: contact
  end

  def destroy
    user = User.find(params[:user_id])
    contact = user.contacts.find(params[:id])
    contact.destroy
    render text: "deleted"
  end

  def belongs_to_user?(user_id, contact)
    contact.user_id == user_id
  end
end
