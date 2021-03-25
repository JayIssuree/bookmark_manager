require 'sinatra'
require 'sinatra/flash'
require 'uri'
require './lib/bookmark'
require './database_connection_setup'

class BookmarkManager < Sinatra::Base

    enable :sessions
    register Sinatra::Flash
    use Rack::MethodOverride

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
        flash[:notice] = "You must submit a valid URL." unless Bookmark.create(name: params[:name], href: params[:url])
        redirect '/bookmarks'
    end

    delete '/bookmarks/:id' do
        Bookmark.delete(id: params[:id])
        redirect '/bookmarks'
    end

    get '/bookmarks/:id/edit' do
        @bookmark = Bookmark.find(id: params[:id])
        erb(:'/bookmarks/edit')
    end

    patch '/bookmarks/:id' do
        flash[:notice] = "You must submit a valid URL." unless Bookmark.update(id: params[:id], name: params[:name], url: params[:url])
        redirect '/bookmarks'
    end


    run! if app_file == $0
end