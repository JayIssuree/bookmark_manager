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

end