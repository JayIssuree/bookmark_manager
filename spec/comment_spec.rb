# require 'bookmark'
require 'database_helpers'
require 'comment'

describe Comment do

    describe ".all" do
        
        it "returns a hard coded list of comments for a bookmark" do
            bookmark = DatabaseConnection.query("INSERT INTO bookmarks (id, name, url) VALUES (1, 'test name', 'https://www.testurl.com') RETURNING id, name, url").first
            comment = Comment.create(text: "this is the first comment1", bookmark_id: bookmark["id"])
            Comment.create(text: "this is the second comment2", bookmark_id: bookmark["id"])
            Comment.create(text: "this is the third comment3", bookmark_id: bookmark["id"])

            comments = Comment.all(bookmark_id: bookmark["id"])
            
            expect(comments.length).to eq(3)
            expect(comments.first.id).to eq(comment.id)
            expect(comments.first.text).to eq("this is the first comment1")
            expect(comments.first.bookmark_id).to eq(bookmark["id"])
            expect(comments.first).to be_a(Comment)
        end

    end
    
    describe ".create" do
        
        it 'creates a comment, saves it to the database and returns the comment' do
            bookmark = DatabaseConnection.query("INSERT INTO bookmarks (id, name, url) VALUES (1, 'test name', 'https://www.testurl.com') RETURNING id, name, url").first
            comment = Comment.create(text: "this is the comment", bookmark_id: bookmark["id"])
            

            persisted_data = persisted_comment_data(id: comment.id)
            expect(comment.id).to eq(persisted_data["id"])
            expect(comment.text).to eq("this is the comment")
            expect(comment.bookmark_id).to eq(bookmark["id"])
            expect(comment).to be_a(Comment)
        end
        
    end

    describe "#initialize" do
        
        it 'is initialized with an id, text and bookmark_id' do
            subject = described_class.new(id: 1, text: 'test comment', bookmark_id: 1)
            expect(subject.id).to eq(1)
            expect(subject.text).to eq('test comment')
            expect(subject.bookmark_id).to eq(1)
        end

    end

end