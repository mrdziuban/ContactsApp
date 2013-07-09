class AuthenticatesController < ApplicationController

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by_email(email)

    if user.password == password
      user.token = SecureRandom.urlsafe_base64(8)
      user.save!
      render text: user.token
    else
      render json: user.errors, status: :unauthorized
    end
  end

  def destroy
    current_user.token = SecureRandom.urlsafe_base64(8)
  end

end
