class Bookmark

    def self.create(name:, href:, comment_class: Comment)
        return false unless is_url?(href)
        result = DatabaseConnection.query("INSERT INTO bookmarks (name, url) VALUES ('#{name}', '#{href}') RETURNING id, name, url")
        Bookmark.new(
            id: result[0]["id"],
            name: result[0]["name"],
            href: result[0]["url"],
            comment_class: comment_class
        )
    end

    def self.delete(id:)
        DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
    end

    def self.find(id:, comment_class: Comment)
        result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
        Bookmark.new(
            id: result[0]["id"],
            name: result[0]["name"],
            href: result[0]["url"],
            comment_class: comment_class
        )
    end

    def self.update(id:, name:, url:, comment_class: Comment)
        return false unless is_url?(url)
        result = DatabaseConnection.query("UPDATE bookmarks SET name = '#{name}', url = '#{url}' WHERE id = #{id} RETURNING id, name, url")
        Bookmark.new(
            id: result[0]["id"],
            name: result[0]["name"],
            href: result[0]["url"],
            comment_class: comment_class
        )
    end

    def self.all(comment_class: Comment)
        result = DatabaseConnection.query("SELECT * FROM bookmarks")
        result.map do |bookmark| 
            Bookmark.new(
                id: bookmark["id"],
                name: bookmark["name"],
                href: bookmark["url"],
                comment_class: comment_class
            )
        end
    end

    attr_reader :id, :name, :href, :comment_class

    def initialize(id:, name:, href:, comment_class: Comment)
        @id = id
        @name = name
        @href = href
        @comment_class = comment_class
    end

    def add_comment(text:)
        comment_class.create(text: text, bookmark_id: self.id)
    end

    def get_comments
        comment_class.all(bookmark_id: self.id)
    end

    private

    def self.is_url?(url)
      url =~ /\A#{URI::regexp(['http', 'https'])}\z/
    end

end