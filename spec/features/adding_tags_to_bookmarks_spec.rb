describe "adding tags to bookmarks", type: :feature do

    before(:each) do
        Tag.create(content: "Health")
        Tag.create(content: "Work")
        Tag.create(content: "Games")
    end
    
    it "has a button to add a tag" do
        Bookmark.create(name: "Google", href: "https://www.google.com")
        visit '/bookmarks'
        expect(page).to have_button("Add Tag")
    end

    it "the button leads to a form which displays all existing tags" do
        bookmark = Bookmark.create(name: "Google", href: "https://www.google.com")
        visit '/bookmarks'
        click_button("Add Tag")
        expect(page.current_path).to eq("/bookmark_tags/#{bookmark.id}/new")
        expect(page).to have_button("Health")
        expect(page).to have_button("Work")
        expect(page).to have_button("Games")
    end

    it "adds the tag to the bookmark" do
        Bookmark.create(name: "Google", href: "https://www.google.com")
        visit '/bookmarks'
        click_button("Add Tag")
        click_button("Work")
        expect(page.current_path).to eq('/bookmarks')
        expect(page).to have_content("Tags: Work")
    end

end