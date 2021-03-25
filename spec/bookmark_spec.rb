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
            bookmark = Bookmark.create(name: "test", href: "https://www.testurl.com")
            persisted_data = persisted_data(id: bookmark.id)
            expect(bookmark.id).to eq(persisted_data["id"])
            expect(bookmark.name).to eq("test")
            expect(bookmark.href).to eq("https://www.testurl.com")
            expect(bookmark).to be_a(Bookmark)
        end

        it "does not create a new bookmark if the URL is not valid" do
            Bookmark.create(name: 'not a real bookmark', href: 'not a real bookmark')
            expect(Bookmark.all).to be_empty
        end

    end

    describe ".delete" do

        it "deletes the bookmark" do
            bookmark = Bookmark.create(name: "test", href: "https://www.testurl.com")
            expect(Bookmark.all.length).to eq(1)
            expect{ Bookmark.delete(id: bookmark.id) }.to change{ Bookmark.all.length }.from(1).to(0)
        end
        
    end

    describe ".find" do
        
        it "finds a and returns a bookmark object from its id" do
            bookmark = Bookmark.create(name: "test", href: "https://www.testurl.com")
            returned_bookmark = Bookmark.find(id: bookmark.id)
            expect(returned_bookmark.id).to eq(bookmark.id)
            expect(returned_bookmark.name).to eq(bookmark.name)
            expect(returned_bookmark.href).to eq(bookmark.href)
        end

    end

    describe ".update" do
        
        it "updates the name and href of a bookmark" do
            bookmark = Bookmark.create(name: "test", href: "https://www.testurl.com")
            updated_bookmark = Bookmark.update(id: bookmark.id, name: "updated_test", url: "https://www.updatedtesturl.com")
            expect(updated_bookmark.id).to eq(bookmark.id)
            expect(updated_bookmark.name).to eq("updated_test")
            expect(updated_bookmark.href).to eq("https://www.updatedtesturl.com")
        end

        it "does not update a bookmark if the URL is not valid" do
            bookmark = Bookmark.create(name: "test", href: "https://www.testurl.com")
            expect(Bookmark.update(id: bookmark.id, name: "updated_test", url: "invalid url")).to be(false)
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