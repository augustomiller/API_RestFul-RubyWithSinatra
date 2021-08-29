require "sinatra"

get "/" do
    content_type "application/json"
    return { message: "Welcome to Book API!" }.to_json
end

get "/books" do
    content_type "application/json"
    books = [
        {title: "Base de Conhecimento em Teste de Software", author: "Aderson Bastos", isbn: "8580630533"},
        {title: "Testes de aplicações mobile", author: "Leonardo Molinari", isbn: "8536520213"},
        {title: "Automatização de Teste de Software com Ferramentas de Software", author: "José Jose Maldonado", isbn: "8535287280"},
        {title: "Qualidade de Software na Pratica", author: "Cleuto Sampaio", isbn: "8539904942"},
        {title: "Código limpo: Habilidades práticas do Agile Software", author: "Robert C. Martin ", isbn: "8576082675"}
    ]
    return books.to_json
end