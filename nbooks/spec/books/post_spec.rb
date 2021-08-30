#ecoding: utf-8

require "httparty"

describe "POST /books" do
    before do
        payload = { 
            title: "The Bugs Book",
            author: "Pequeno Gafanhoto",
            isbn: "8580630333"
        }

        @resp = HTTParty.post(
            "http://localhost:4567/books",
            body: payload.to_json
        )
    end

    it "CN-3 Deve retornar 201." do
        expect(@resp.code).to eql 201
    end
end