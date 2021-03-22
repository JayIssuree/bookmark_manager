describe "Viewing bookmarks", type: :feature do
    
    it 'contains the list of hard coded bookmarks' do
        visit '/'
        click_button 'View Bookmarks'
        expect(page).to have_link("Google", :href => "https://www.google.com")
        expect(page).to have_link("YouTube", :href => "https://www.youtube.com")
        expect(page).to have_link("Github", :href => "https://www.github.com")
    end

end