require 'pg'

class Bookmark

    def self.all
        if ENV['RACK_ENV'] == 'test'
            connection = PG.connect(dbname: 'bookmark_manager_test')
        else
            connection = PG.connect(dbname: 'bookmark_manager')
        end
        result = connection.exec('SELECT * FROM bookmarks')
        result.map do |bookmark| 
            Bookmark.new(
                name: bookmark['name'],
                href: bookmark['url']
            )
        end
    end

    attr_reader :name, :href

    def initialize(name:, href:)
        @name = name
        @href = href
    end

end