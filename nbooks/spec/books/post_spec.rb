#ecoding: utf-8

require "httparty"

describe "POST /books" do

    context "Quando o payload é ok:" do
        before do
            payload = { 
                title: "The Bugs Book",
                author: "Pequeno Gafanhoto",
                isbn: Faker::Code.isbn
            }
    
            @resp = BaseApi.post(
                "/books",
                body: payload.to_json
            )
        end
    
        it "CN-3 Deve retornar 201." do
            expect(@resp.code).to eql 201
        end
    end

    context "Quando o payload é nulo." do
        before do
            @resp = BaseApi.post(
                "/books",
                body: nil,
            )
        end
    
        it "CN-4 Deve retornar 400." do
            expect(@resp.code).to eql 400
        end 
    end

    context "Quando o ISBN já existe." do

        before do
            payload = { 
                title: "Arquitetura limpa",
                author: "Robert C. Martin",
                isbn: Faker::Code.isbn
            }
            # O primeiro post faz o cadastro e o segundo testa...
            BaseApi.post( "/books", body: payload.to_json )
            @resp = BaseApi.post( "/books", body: payload.to_json )

        end

        it "CN-5 ISBN duplicado | Deve retornar 409." do
            expect(@resp.code).to eql 409
        end
    end

    context "Quando o título não existe no payload." do
        before do
            payload = { author: "Pequeno Gafanhoto", isbn: Faker::Code.isbn }
            @resp = BaseApi.post( "/books", body: payload.to_json )
        end

        it "CN-6 Título Nulo | Deve retornar 409." do
            expect(@resp.code).to eql 409
        end

        it "CN-7 Deve retornar mensagem de erro." do
            expect(@resp.parsed_response["error"]).to eql "Título é obrigatório!"
        end
    end

    context "Quando o Autor não existe no payload." do
        before do
            payload = { title: "O Gafanhoto", isbn: Faker::Code.isbn }
            @resp = BaseApi.post( "/books", body: payload.to_json )
        end

        it "CN-8 Autor Nulo | Deve retornar 409." do
            expect(@resp.code).to eql 409
        end

        it "CN-9 Deve retornar mensagem de erro." do
            expect(@resp.parsed_response["error"]).to eql "Autor é obrigatório!"
        end
    end

    context "Quando o ISBN não existe no payload." do
        before do
            payload = { title: "O Gafanhoto", author: "M. Miller" }
            @resp = BaseApi.post( "/books", body: payload.to_json )
        end

        it "CN-10 ISBN Nulo | Deve retornar 409." do
            expect(@resp.code).to eql 409
        end

        it "CN-11 Deve retornar mensagem de erro." do
            expect(@resp.parsed_response["error"]).to eql "ISBN é obrigatório!"
        end
    end
end