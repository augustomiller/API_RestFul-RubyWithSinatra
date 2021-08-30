#ecoding: utf-8

require "httparty"

describe "POST /books" do

    context "Quando o payload é ok:" do
        before do
            payload = { 
                title: "The Bugs Book",
                author: "Pequeno Gafanhoto",
                isbn: "8580630333"
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

    context "Quando o payload é nulo:" do
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
end