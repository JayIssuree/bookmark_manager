require 'pg'

def persisted_bookmark_data(id:)
    connection = PG.connect(dbname: 'bookmark_manager_test')
    result = connection.exec("SELECT * FROM bookmarks WHERE id = #{id};")
    result.first
end

def persisted_comment_data(id:)
    connection = PG.connect(dbname: 'bookmark_manager_test')
    result = connection.exec("SELECT * FROM comments WHERE id = #{id};")
    result.first
end