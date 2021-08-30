require "sinatra"
require "sinatra/namespace"
require "mongoid"

# Mongo DB connect
Mongoid.load! "mongoid.yml"

# Model - Modelo de Dados
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

    get "/:book_id" do |book_id|
        book = Book.where(_id: book_id).first

        unless book
            halt 404, {}.to_json 
        end

        return book.to_json
    end

    delete "/:book_id" do |book_id|
        book = Book.where(_id: book_id).first
        book.destroy if book
        status 204
    end

    post do
        begin
            payload = JSON.parse(request.body.read)

            #Valida Titulo nulo.
            unless payload["title"]
               halt 409, { error: "Título é obrigatório!" }.to_json
            end

            #Valida Autor nulo.
            unless payload["author"]
                halt 409, { error: "Autor é obrigatório!" }.to_json
            end

            #Valida ISBN nulo.
            unless payload["isbn"]
                halt 409, { error: "ISBN é obrigatório!" }.to_json
            end

            #Valida duplicidade de ISBN.
            found = Book.where(isbn: payload["isbn"]).first

            if found
                halt 409, { error: "ISBN Dupilcado!" }.to_json
            end

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