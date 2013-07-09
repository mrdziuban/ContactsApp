class ContactsController < ApplicationController
  before_filter :authenticate, except: [:search]

  def create
    contact = current_user.contacts.build(params[:contact])

    if contact.save
      render json: contact
    else
      render json: contact.errors, status: :unprocessable_entity
    end
  end

  def index
    render :json => current_user.contacts
  end

  # Needs failing error codes

  def update
    contact = Contact.find(params[:id])

    if contact.user_id == current_user.id
      contact.update_attributes(params[:contact])
      render json: contact
    else
      render text: "That's not your contact!"
    end
  end

  def search
    name = params[:name]
    address = params[:address]
    email = params[:email]
    phone_number = params[:phone_number]

    render json: Contact.where("name LIKE '%#{name}%' AND address LIKE '%#{address}%' AND email LIKE '%#{email}%' AND phone_number LIKE '%#{phone_number}%'")
  end

  def destroy
    contact = Contact.find(params[:id])

    if contact.user_id == current_user.id
      contact.destroy
      render text: "deleted"
    else
      render text: "You can't delete that user!"
    end
  end
end
