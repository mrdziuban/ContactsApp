require 'addressable/uri'
require 'rest-client'
require 'JSON'

class ContactClient
  def self.login
    puts "Please enter your email:"
    email = gets.chomp
    puts "Please enter your password:"
    password = gets.chomp
    url = url_builder('/authenticates')

    token = RestClient.post(url, {email: email, password: password})

    ContactClient.new(token)
  end

  def self.url_builder(path, query_values = nil)
    Addressable::URI.new(
      scheme: 'http',
      host: 'localhost',
      port: 3000,
      path: path,
      query_values: query_values
    ).to_s
  end

  def self.create_user
    puts "Enter your name:"
    name = gets.chomp
    puts "Enter your email:"
    email = gets.chomp
    puts "Enter your password:"
    password = gets.chomp

    url = url_builder("/users")
    RestClient.post(url, {user: {name: name, email: email, password: password}})

    puts "User created. Please login."
    self.login
  end

  attr_accessor :user

  def initialize(token)
    @token = token
    @user = User.find_by_token(token)
    run
  end

  def user
    @user.reload
  end

  def run
    loop do
      system("clear")
      puts "Contact Manager"
      puts "=" * 15
      puts "1. Add contact\n2. Update contact\n3. Delete contact\n4. List contacts\n\
5. Add favorite\n6. Delete favorite\n7. List favorites\n8. Update user info\n\
9. Delete yourself\n10. Quit"
      choice = gets.chomp.to_i

      case choice
      when 1
        add_contact
      when 2
        update_contact
      when 3
        delete_contact
      when 4
        list_contacts
        gets.chomp
      when 5
        add_favorite
      when 6
        delete_favorite
      when 7
        list_favorites
        gets.chomp
      when 8
        update_user
      when 9
        delete_user
        break
      when 10
        break
      end
    end
  end

  def add_contact
    url = self.class.url_builder("/users/#{@user.id}/contacts")
    RestClient.post(url,{token: @token, contact: get_contact_info})

    puts "Contact created!"
  end

  def update_contact
    user.contacts.each do |contact|
      puts "ID: #{contact.id}, NAME: #{contact.name}"
    end
    puts "What is the ID of the contact you want to update?"
    id = gets.chomp

    url = self.class.url_builder("/contacts/#{id}")
    RestClient.put(url, {token: @token, contact: get_contact_info})

    puts "Contact updated!"
  end

  def get_contact_info
    contact = {}
    puts "What is the contacts name?"
    contact[:name] = gets.chomp
    puts "What is the contacts address?"
    contact[:address] = gets.chomp
    puts "What is the contacts phone number?"
    contact[:phone_number] = gets.chomp
    puts "What is the contacts email?"
    contact[:email] = gets.chomp
    contact
  end

  def delete_contact
    user.contacts.each do |contact|
      puts "ID: #{contact.id}, NAME: #{contact.name}"
    end
    puts "What is the ID of the contact you want to delete?"
    id = gets.chomp
    url = self.class.url_builder("/contacts/#{id}", {token: @token})
    RestClient.delete(url)

    puts "Contact deleted!"
  end

  def list_contacts
    user.contacts.each do |contact|
      puts "ID: #{contact.id}, NAME: #{contact.name}, ADDRESS: #{contact.address}, PHONE: #{contact.phone_number}, EMAIL: #{contact.email}"
    end
    nil
  end

  def add_favorite
    user.contacts.each do |contact|
      puts "ID: #{contact.id}, NAME: #{contact.name}"
    end
    puts "What is the ID of the contact you want to favorite?"
    contact_id = gets.chomp
    url = self.class.url_builder("/users/#{@user.id}/favorites")
    RestClient.post(url,{contact_id: contact_id, token: @token})

    puts "Contact favorited!"
  end

  def delete_favorite
    user.favorites.each do |favorite|
      puts "ID: #{favorite.id}, NAME: #{favorite.contact.name}"
    end
    puts "What is the ID of the contact you want to unfavorite?"
    favorite_id = gets.chomp
    fav_to_delete = Favorite.find(favorite_id)
    url = self.class.url_builder("/contacts/#{fav_to_delete.contact.id}/favorites/#{favorite_id}",{id: favorite_id, token: @token})
    RestClient.delete(url)

    puts "Unfavorited!"
  end

  def list_favorites
    user.favorites.each do |favorite|
      puts "NAME: #{favorite.contact.name}, ADDRESS: #{favorite.contact.address}, PHONE: #{favorite.contact.phone_number}, EMAIL: #{favorite.contact.email}"
    end
    nil
  end

  def update_user
    user = {}
    puts "Enter name:"
    user[:name] = gets.chomp
    puts "Enter email:"
    user[:email] = gets.chomp
    puts "Enter password:"
    user[:password] = gets.chomp

    url = self.class.url_builder("/users/#{@user.id}")
    RestClient.put(url, {token: @token, user: user})

    puts "User updated!"
  end

  def delete_user
    url = self.class.url_builder("/users/#{@user.id}", {token: @token})
    RestClient.delete(url)

    puts "User deleted!"
  end

end