require "sinatra"

get "/" do
    content_type "application/json"
    return { message: "Welcome to Book API!" }.to_json
end