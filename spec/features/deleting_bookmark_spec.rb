describe "deleting a bookmark", type: :feature do

    it "has a delete bookmark button" do
        Bookmark.create(name: "Google", href: "https://www.google.com")

        visit '/'
        click_button 'View Bookmarks'
        expect(page).to have_button("Delete Bookmark")
    end

    it "deletes the bookmark" do
        Bookmark.create(name: "Google", href: "https://www.google.com")

        visit '/'
        click_button 'View Bookmarks'
        expect(page).to have_link("Google", :href => "https://www.google.com")
        click_button 'Delete Bookmark'
        expect(page.current_path).to eq('/bookmarks')
        expect(page).not_to have_link("Google", :href => "https://www.google.com")
    end

end