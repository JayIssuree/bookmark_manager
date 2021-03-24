describe "updating a bookmark", type: :feature do

    it "has an update bookmark button" do
        Bookmark.create(name: "Google", href: "https://www.google.com")

        visit '/'
        click_button 'View Bookmarks'
        expect(page).to have_button("Update Bookmark")
    end

    it "has a form to update the bookmark" do
        bookmark = Bookmark.create(name: "Google", href: "https://www.google.com")

        visit '/'
        click_button 'View Bookmarks'
        expect(page).to have_link("Google", :href => "https://www.google.com")
        click_button 'Update Bookmark'
        expect(page.current_path).to eq("/bookmarks/#{bookmark.id}/edit")
        expect(page).to have_field("name", with: "Google")
        expect(page).to have_field("url", with: "https://www.google.com")
        expect(page).to have_button('Save')
    end

    it "updates the bookmark" do
        bookmark = Bookmark.create(name: "Google", href: "https://www.google.com")

        visit '/'
        click_button 'View Bookmarks'
        click_button 'Update Bookmark'
        fill_in("name", with: "Test")
        fill_in("url", with: "https://www.testurl.com")
        click_button 'Save'
        expect(page.current_path).to eq("/bookmarks")
        expect(page).not_to have_link("Google", :href => "https://www.google.com")
        expect(page).to have_link("Test", :href => "https://www.testurl.com")
    end

end