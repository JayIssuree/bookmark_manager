require 'pg'

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

    attr_reader :id, :name, :href

    def initialize(id:, name:, href:)
        @id = id
        @name = name
        @href = href
    end

    private

    def self.is_url?(url)
      url =~ /\A#{URI::regexp(['http', 'https'])}\z/
    end

end