require "sinatra"
require "sinatra/namespace"
require "mongoid"

# Mongo DB connect
Mongoid.load! "mongoid.yml"

class Book
    include Mongoid::Document

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

    post do
        begin
            payload = JSON.parse(request.body.read)
            book = Book.new(payload)
            book.save
            status 201
            return book.to_json      
        rescue => exception
            puts exception
            halt 400, { error: exception }.to_json
        end

    end
end