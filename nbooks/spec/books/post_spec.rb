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

        it "CN-5 Deve retornar 409." do
            expect(@resp.code).to eql 409
        end
    end
end