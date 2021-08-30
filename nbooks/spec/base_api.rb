require "httparty"

class BaseApi
    include HTTParty
    base_uri "http://localhost:4567"
end