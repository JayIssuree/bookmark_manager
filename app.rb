require 'sinatra'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

    get '/' do
        erb(:homepage)
    end

    get '/bookmarks' do
        @bookmarks = Bookmark.all
        erb(:'bookmarks/index')
    end

    get '/bookmarks/new' do
        erb(:'bookmarks/new')
    end

    post '/bookmarks' do
        Bookmark.create(name: params["name"], href: params["url"])
        redirect '/'
    end


    run! if app_file == $0
end