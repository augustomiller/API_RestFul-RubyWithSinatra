describe "GET /" do

    before do
        @resp = BaseApi.get("/")
    end

    it "CN-1 Deve retirnar Status code 200" do
        expect(@resp.code).to eql 200
    end

    it "CN-2 Deve retornar welcome" do
      expect(@resp.parsed_response["message"]).to eql "Welcome to Book API!"
    end

end