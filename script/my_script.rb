require 'addressable/uri'
require 'rest-client'
require 'JSON'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/contacts/2',
  query_values: {token: "bwmQxG6m8KU"}
  #   'some_category[a_key]' => 'another value',
  #   'some_category[a_second_key]' => 'yet another value',
  #   'some_cateogry[inner_inner_hash][key]' => 'value',
  #   'something_else' => 'aaahhhhh'
  # }
).to_s

# p JSON.parse(RestClient.post(url,{user: {name: "Sid",email:"siadsraval@gmail.com",password:"test"}}))

# p JSON.parse(RestClient.put(url,{user:
#  {name: "Not Sid"},token: "bwmQxG6m8KU"}))

#p JSON.parse(RestClient.delete(url))

p JSON.parse(RestClient.delete(url))