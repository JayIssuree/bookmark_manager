require 'sinatra'
require 'sinatra/flash'
require 'uri'
require './lib/bookmark'
require './lib/comment'
require './lib/tag'
require './lib/bookmark_tag'
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
        @tags = Tag.all
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

    get '/bookmarks/:bookmark_id/comments/new' do
        erb(:"/bookmarks/comments/new")
    end

    post '/bookmarks/:bookmark_id/comments' do
        Bookmark.find(id: params[:bookmark_id]).add_comment(text: params[:comment_text])
        redirect '/bookmarks'
    end

    get '/tags/new' do
        erb(:'/tags/new')
    end

    post '/tags' do
        Tag.create(content: params[:tag_name])
        redirect '/bookmarks'
    end

    get '/bookmark_tags/:bookmark_id/new' do
        @tags = Tag.all
        erb(:'/bookmark_tags/new')
    end

    post '/bookmark_tags/:bookmark_id/:tag_id' do
        BookmarkTag.create(bookmark_id: params[:bookmark_id], tag_id: params[:tag_id])
        redirect '/bookmarks'
    end

    run! if app_file == $0
end