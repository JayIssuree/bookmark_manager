require 'bookmark_tag'
require 'bookmark'
require 'tag'
require 'database_helpers'

describe BookmarkTag do

    describe '.create' do

        it "saves a bookmark tag to the database and returns a bookmark tag object" do            
            bookmark = Bookmark.create(name: "Google", href: "https://www.google.com")
            tag = Tag.create(content: "Example tag 1")
            bookmark_tag = BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag.id)
            persisted_data = persisted_data(table: 'bookmark_tags', id: bookmark_tag.id)
            expect(bookmark_tag.id).to eq(persisted_data['id'])
            expect(bookmark_tag.bookmark_id).to eq(bookmark.id)
            expect(bookmark_tag.tag_id).to eq(tag.id)
        end

    end

    describe '#initialize' do
        
        it "is initialized with an id, bookmark_id and tag_id" do
            bookmark_tag = BookmarkTag.new(id: 1, bookmark_id: 2, tag_id: 3)
            expect(bookmark_tag.id).to eq(1)
            expect(bookmark_tag.bookmark_id).to eq(2)
            expect(bookmark_tag.tag_id).to eq(3)
        end

    end
    
end