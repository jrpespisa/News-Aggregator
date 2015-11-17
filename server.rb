require "sinatra"
require "csv"

set :public_folder, File.join(File.dirname(__FILE__), "public")


get "/articles" do
  @articles = CSV.parse(File.read("articles.csv"))
  erb :articles
end

get "/articles/new" do
  erb :articles_new
end

post "/articles/new" do
  @title = params["title"]
  @description = params["description"]
  @url = params["url"]
  CSV.open("articles.csv", "a+") do |csv|
    csv << [@title, @description, @url]
  end
  redirect "/articles"
end
