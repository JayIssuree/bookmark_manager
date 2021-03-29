class Bookmark

    def self.create(name:, href:)
        return false unless is_url?(href)
        result = DatabaseConnection.query("INSERT INTO bookmarks (name, url) VALUES ('#{name}', '#{href}') RETURNING id, name, url")
        Bookmark.new(
            id: result[0]["id"],
            name: result[0]["name"],
            href: result[0]["url"]
        )
    end

    def self.delete(id:)
        DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
    end

    def self.find(id:)
        result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
        Bookmark.new(
            id: result[0]["id"],
            name: result[0]["name"],
            href: result[0]["url"]
        )
    end

    def self.update(id:, name:, url:)
        return false unless is_url?(url)
        result = DatabaseConnection.query("UPDATE bookmarks SET name = '#{name}', url = '#{url}' WHERE id = #{id} RETURNING id, name, url")
        Bookmark.new(
            id: result[0]["id"],
            name: result[0]["name"],
            href: result[0]["url"]
        )
    end

    def self.all
        result = DatabaseConnection.query("SELECT * FROM bookmarks")
        result.map do |bookmark| 
            Bookmark.new(
                id: bookmark["id"],
                name: bookmark["name"],
                href: bookmark["url"]
            )
        end
    end

    attr_reader :id, :name, :href, :comment_class

    def initialize(id:, name:, href:)
        @id = id
        @name = name
        @href = href
        @comment_class = comment_class
    end

    def add_comment(comment_class: Comment, text:)
        comment_class.create(text: text, bookmark_id: self.id)
    end

    def get_comments(comment_class: Comment)
        comment_class.all(bookmark_id: self.id)
    end

    def tags
        bookmark_tags.map do |bookmark_tag| 
            Tag.find(id: bookmark_tag["tag_id"])
        end
    end

    private

    def self.is_url?(url)
      url =~ /\A#{URI::regexp(['http', 'https'])}\z/
    end

    def bookmark_tags
        DatabaseConnection.query("SELECT * FROM bookmark_tags WHERE bookmark_id = #{self.id}")
    end

end