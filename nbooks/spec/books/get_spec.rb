describe "GET /books" do

    before do
        @resp = BaseApi.get("/books")
    end

    it "CN-1 Deve retornar Status code 200." do
        expect(@resp.code).to eql 200
    end

    it "CN-2 Deve retornar uma lista >= zero." do
      #puts @resp.parsed_response
      #puts @resp.parsed_response.class
      expect(@resp.parsed_response.size).to be >= 0
      expect(@resp.parsed_response.class).to eql Array
    end
end

describe "GET /books/:_id" do
    context "Quando busco por ID." do
        before do
            @payload = { 
                title: "The Book",
                author: "Pequeno",
                isbn: Faker::Code.isbn
            }
    
            book = BaseApi.post(
                "/books",
                body: @payload.to_json
            )

            book_id = book.parsed_response["id"]
            @resp = BaseApi.get("/books/#{book_id}")
        end
    
        it "CN-12 Deve retornar Status code 200." do
            expect(@resp.code).to eql 200
        end
    
        it "CN-13 Deve retornar os dados." do
            expect(@resp.parsed_response["title"]).to eql @payload[:title]
            expect(@resp.parsed_response["author"]).to eql @payload[:author]
            expect(@resp.parsed_response["isbn"]).to eql @payload[:isbn]
        end
    end


    context "Quando o id não existe" do

        before do
            book_id = Faker::Alphanumeric.alpha(number: 24)
            @resp = BaseApi.get("/books/#{book_id}")
        end

        it "CN-14 Deve retornar 404" do
            expect(@resp.code).to eql 404
        end

        it "CN-15 Deve retornar json vazio" do
            expect(@resp.parsed_response).to be_empty
        end
    end
end