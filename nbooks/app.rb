require "sinatra"
require "sinatra/namespace"
require "mongoid"

# Mongo DB connect
Mongoid.load! "mongoid.yml"

class Book
    include Mongoid::Document

    field :id, type: Object
    field :title, type: String
    field :author, type: String
    field :isbn, type: String
end

get "/" do
    content_type "application/json"
    return { message: "Welcome to Book API!" }.to_json
end

namespace "/books" do

    before do
        content_type "application/json"
    end

    get do
        return Book.all.to_json
    end
end