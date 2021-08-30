describe "DELETE /books/:_id" do
    context "[exclusão] Quando excluo por ID." do
        before do
            @payload = { 
                title: "Comportamento Aleatorio",
                author: "Leonardo Molinari",
                isbn: Faker::Code.isbn
            }
    
            book = BaseApi.post(
                "/books",
                body: @payload.to_json
            )

            book_id = book.parsed_response["id"]
            @resp = BaseApi.delete("/books/#{book_id}")
        end
    
        it "CN-16 [exclusão] Deve retornar Status code 204." do
            expect(@resp.code).to eql 204
        end
    end


    context "[exclusão] Quando o id não existe" do

        before do
            book_id = Faker::Alphanumeric.alpha(number: 24)
            @resp = BaseApi.delete("/books/#{book_id}")
        end

        it "CN-17 [exclusão] Deve retornar 204" do
            expect(@resp.code).to eql 204
        end
    end
end