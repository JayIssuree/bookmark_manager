require 'pg'

describe "Viewing bookmarks", type: :feature do
    
    it 'contains the list of hard coded bookmarks' do
        connection = PG.connect(dbname: 'bookmark_manager_test')
        connection.exec("INSERT INTO bookmarks (name, url) VALUES ('Google', 'https://www.google.com')")
        connection.exec("INSERT INTO bookmarks (name, url) VALUES ('YouTube', 'https://www.youtube.com')")
        connection.exec("INSERT INTO bookmarks (name, url) VALUES ('Github', 'https://www.github.com')")
        
        visit '/'
        click_button 'View Bookmarks'
        expect(page).to have_link("Google", :href => "https://www.google.com")
        expect(page).to have_link("YouTube", :href => "https://www.youtube.com")
        expect(page).to have_link("Github", :href => "https://www.github.com")
    end

end