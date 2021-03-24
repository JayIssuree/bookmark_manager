require 'pg'

class Bookmark

    def self.create(name:, href:)
        if ENV['RACK_ENV'] == "test"
            connection = PG.connect(dbname: "bookmark_manager_test")
        else
            connection = PG.connect(dbname: "bookmark_manager")
        end
        result = connection.exec("INSERT INTO bookmarks (name, url) VALUES ('#{name}', '#{href}') RETURNING id, name, url")
        Bookmark.new(
            id: result[0]["id"],
            name: result[0]["name"],
            href: result[0]["url"]
        )
    end

    def self.delete(id:)
        if ENV['RACK_ENV'] == "test"
            connection = PG.connect(dbname: "bookmark_manager_test")
        else
            connection = PG.connect(dbname: "bookmark_manager")
        end
        connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
    end

    def self.all
        if ENV['RACK_ENV'] == "test"
            connection = PG.connect(dbname: "bookmark_manager_test")
        else
            connection = PG.connect(dbname: "bookmark_manager")
        end
        result = connection.exec("SELECT * FROM bookmarks")
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

end