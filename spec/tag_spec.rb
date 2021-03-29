require 'tag'
require 'database_helpers'

describe Tag do
    
    describe ".create" do
        
        it "saves a tag to the database and returns a tag object" do
            tag = Tag.create(content: "Example tag 1")
            persisted_data = persisted_data(table: "tags", id: tag.id)
            expect(tag.id).to eq(persisted_data['id'])
            expect(tag.content).to eq("Example tag 1")
        end

    end

    describe ".all" do
        
        it "returns an array of tags" do
            tag = Tag.create(content: "Example tag 1")
            Tag.create(content: "Example tag 2")
            Tag.create(content: "Example tag 3")
            tags = Tag.all
            expect(tags.length).to eq(3)
            expect(tags.first.id).to eq(tag.id)
            expect(tags.first.content).to eq("Example tag 1")
        end

    end

    describe ".find" do
        
        it "finds and returns the tag given its id" do
            tag = Tag.create(content: "Example tag 1")
            found_tag = Tag.find(id: tag.id)
            expect(found_tag).to be_a(Tag)
            expect(found_tag.content).to eq(tag.content)
            expect(found_tag.id).to eq(tag.id)
        end

    end

    describe "#initialize" do
        
        it "is initialized with an id and content" do
            tag = Tag.new(id: 1, content: "Example tag 1")
            expect(tag.id).to eq(1)
            expect(tag.content).to eq("Example tag 1")
        end

    end

    describe "#bookmarks" do
        
        it "returns an array of bookmarks for a given tag" do
            bookmark1 = Bookmark.create(name: "Google", href: "https://www.google.com")
            bookmark2 = Bookmark.create(name: "YouTube", href: "https://www.youtube.com")
            tag = Tag.create(content: 'test tag 1')
            BookmarkTag.create(bookmark_id: bookmark1.id, tag_id: tag.id)
            BookmarkTag.create(bookmark_id: bookmark2.id, tag_id: tag.id)
            expect(tag.bookmarks.length).to eq(2)
            expect(tag.bookmarks.first.name).to eq(bookmark1.name)
            expect(tag.bookmarks[1].href).to eq(bookmark2.href)
            expect(tag.bookmarks.first).to be_a(Bookmark)
        end

    end

end