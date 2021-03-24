require 'bookmark'
require 'database_helpers'

describe Bookmark do

    describe ".all" do
        
        it "returns a hard coded list of bookmarks" do
            bookmark = Bookmark.create(name: "Google", href: "https://www.google.com")
            Bookmark.create(name: "YouTube", href: "https://www.youtube.com")
            Bookmark.create(name: "Github", href: "https://www.github.com")

            bookmarks = Bookmark.all
            
            expect(bookmarks.length).to eq(3)
            expect(bookmarks.first.id).to eq(bookmark.id)
            expect(bookmarks.first.name).to eq("Google")
            expect(bookmarks.first.href).to eq("https://www.google.com")
            expect(bookmarks.first).to be_a(Bookmark)
        end

    end

    describe ".create" do
        
        it "creates a bookmark, saves it to the database and returns a bookmark" do
            bookmark = Bookmark.create(name: "test", href: "www.testurl.com")
            persisted_data = persisted_data(id: bookmark.id)
            expect(bookmark.id).to eq(persisted_data["id"])
            expect(bookmark.name).to eq("test")
            expect(bookmark.href).to eq("www.testurl.com")
            expect(bookmark).to be_a(Bookmark)
        end

    end
    
    describe "intialize" do
        
        it "is initialized with an id, name and href link" do
            subject = described_class.new(id: 1, name: "Google", href: "https://www.google.com")
            expect(subject.id).to eq(1)
            expect(subject.name).to eq("Google")
            expect(subject.href).to eq("https://www.google.com")
        end

    end

end