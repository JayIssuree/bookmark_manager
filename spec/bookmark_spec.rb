require 'bookmark'

describe Bookmark do

    describe ".all" do
        
        it "returns a hard coded list of bookmarks" do
            connection = PG.connect(dbname: 'bookmark_manager_test')
            connection.exec("INSERT INTO bookmarks (name, url) VALUES ('Google', 'https://www.google.com')")
            connection.exec("INSERT INTO bookmarks (name, url) VALUES ('YouTube', 'https://www.youtube.com')")
            connection.exec("INSERT INTO bookmarks (name, url) VALUES ('Github', 'https://www.github.com')")
            # Bookmark.create(name: "Google", href: "https://www.google.com")
            # Bookmark.create(name: "YouTube", href: "https://www.youtube.com")
            # Bookmark.create(name: "Github", href: "https://www.github.com")
            
            expect(Bookmark.all.length).to eq(3)
            bookmark1 = Bookmark.all[0]
            bookmark2 = Bookmark.all[1]
            bookmark3 = Bookmark.all[2]
            expect(bookmark1.name).to eq("Google")
            expect(bookmark1.href).to eq("https://www.google.com")
            expect(bookmark2.name).to eq("YouTube")
            expect(bookmark2.href).to eq("https://www.youtube.com")
            expect(bookmark3.name).to eq("Github")
            expect(bookmark3.href).to eq("https://www.github.com")
        end

    end

    describe ".create" do
        
        it "creates a bookmark and saves it to the database" do
            Bookmark.create(name: "test", href: "www.testurl.com")
            expect(Bookmark.all.first.name).to eq("test")
            expect(Bookmark.all.first.href).to eq("www.testurl.com")
        end

    end
    
    describe "intialize" do
        
        it "is initialized with a name and href link" do
            subject = described_class.new(name: "Google", href: "https://www.google.com")
            expect(subject.name).to eq("Google")
            expect(subject.href).to eq("https://www.google.com")
        end

    end

end