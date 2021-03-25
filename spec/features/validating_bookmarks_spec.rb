describe "validating bookmarks", type: :feature do
    
    it 'displays a flash message when an invlaid url is given' do
        visit('/bookmarks/new')
        fill_in('name', with: 'fake name')
        fill_in('url', with: 'not a real bookmark')
        click_button('Save Bookmark')
      
        expect(page).not_to have_content "fake name"
        expect(page).to have_content "You must submit a valid URL."
    end

    it 'displays a flash message when an invlaid url is given when updating a bookmark' do
        bookmark = Bookmark.create(name: "Google", href: "https://www.google.com")

        visit '/'
        click_button 'View Bookmarks'
        click_button 'Update Bookmark'
        fill_in("name", with: "Test")
        fill_in("url", with: "invalid url")
        click_button 'Save'
        expect(page.current_path).to eq("/bookmarks")
        expect(page).to have_link("Google", :href => "https://www.google.com")
        expect(page).to have_content "You must submit a valid URL."
    end

end