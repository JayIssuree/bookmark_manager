class Bookmark

    def self.all
        [
            Bookmark.new(name: "Google", href: "https://www.google.com"),
            Bookmark.new(name: "YouTube", href: "https://www.youtube.com"),
            Bookmark.new(name: "Github", href: "https://www.github.com")
        ]
    end

    attr_reader :name, :href

    def initialize(name:, href:)
        @name = name
        @href = href
    end

end