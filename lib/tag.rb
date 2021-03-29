class Tag

    def self.create(content:)
        result = DatabaseConnection.query("INSERT INTO tags (content) VALUES ('#{content}') RETURNING id, content;")
        Tag.new(
            id: result[0]['id'],
            content: result[0]['content']
        )
    end

    def self.all
        result = DatabaseConnection.query("SELECT * FROM tags;")
        result.map do |tag|
            Tag.new(
                id: tag['id'],
                content: tag['content']
            )
        end
    end

    def self.find(id:)
        result = DatabaseConnection.query("SELECT * FROM tags WHERE id = #{id}")
        Tag.new(
            id: result[0]['id'],
            content: result[0]['content']
        )
    end

    attr_reader :id, :content

    def initialize(id:, content:)
        @id = id
        @content = content
    end

    def bookmarks
        bookmark_tags.map do |bookmark_tag|
            Bookmark.find(id: bookmark_tag['bookmark_id'])
        end
    end

    private

    def bookmark_tags
        DatabaseConnection.query("SELECT * FROM bookmark_tags WHERE tag_id = #{self.id}")
    end

end