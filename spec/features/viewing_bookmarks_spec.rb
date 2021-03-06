require 'pg'

describe "Viewing bookmarks", type: :feature do
    
    it 'contains the list of hard coded bookmarks' do
        Bookmark.create(name: "Google", href: "https://www.google.com")
        Bookmark.create(name: "YouTube", href: "https://www.youtube.com")
        Bookmark.create(name: "Github", href: "https://www.github.com")
        
        visit '/'
        click_button 'View Bookmarks'
        expect(page).to have_link("Google", :href => "https://www.google.com")
        expect(page).to have_link("YouTube", :href => "https://www.youtube.com")
        expect(page).to have_link("Github", :href => "https://www.github.com")
    end

end