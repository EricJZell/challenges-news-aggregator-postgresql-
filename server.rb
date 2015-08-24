##Eric Zell Launch Academy news aggregator challenge 8/13/15 ##
require "sinatra"
require 'csv'
require 'pry'
require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: "news_aggregator_development")
    yield(connection)
  ensure
    connection.close
  end
end

get "/articles" do
  articles = db_connection { |conn| conn.exec("SELECT title, url, description FROM articles") }
  #pry
  erb :index, locals: { articles: articles }
end

get "/articles/new" do
  erb :new, locals: {repeat: false, title: "title", url: "http://", description: "..." }
end

post "/articles/new" do
  begin
    db_connection do |conn|
      conn.exec_params("INSERT INTO articles (title, url, description) VALUES ($1, $2, $3)", [params[:title], params[:url], params[:description]])
    end
    redirect "/articles"
  rescue
    erb :new, locals: {repeat: true, title: params[:title], url: "http://", description: params[:description] }
  end
end
