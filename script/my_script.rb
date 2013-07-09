require 'addressable/uri'
require 'rest-client'
require 'JSON'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1/favorites/2'
  # query_values: {
  #   'some_category[a_key]' => 'another value',
  #   'some_category[a_second_key]' => 'yet another value',
  #   'some_cateogry[inner_inner_hash][key]' => 'value',
  #   'something_else' => 'aaahhhhh'
  # }
).to_s

# p JSON.parse(RestClient.put(url,{contact:
#   {address: "456 Stupid Street", name: "Homer Simpson", email: "elhomo@simpsons.com",
#     phone_number: "5555555555"}
#   }))

p JSON.parse(RestClient.delete(url))