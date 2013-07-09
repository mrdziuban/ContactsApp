require 'addressable/uri'
require 'rest-client'
require 'JSON'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1.json'
  # query_values: {
  #   'some_category[a_key]' => 'another value',
  #   'some_category[a_second_key]' => 'yet another value',
  #   'some_cateogry[inner_inner_hash][key]' => 'value',
  #   'something_else' => 'aaahhhhh'
  # }
).to_s

p JSON.parse(RestClient.get(url))