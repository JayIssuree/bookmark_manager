describe "commenting on bookmarks", type: :feature do
    
    it "has an add comment button" do
        Bookmark.create(name: "Google", href: "https://www.google.com")

        visit '/'
        click_button 'View Bookmarks'
        expect(page).to have_button("Add Comment")
    end

    it "the button leads to a form to input the text for the comment" do
        bookmark = Bookmark.create(name: "Google", href: "https://www.google.com")

        visit '/bookmarks'
        click_button("Add Comment")
        expect(page).to have_field("comment_text")
        expect(page).to have_button("Save Comment")
        expect(page.current_path).to eq("/bookmarks/#{bookmark.id}/comments/new")
    end

    it "saves the comment and can be seen below the bookmark" do
        Bookmark.create(name: "Google", href: "https://www.google.com")

        visit '/bookmarks'
        click_button("Add Comment")
        fill_in("comment_text", with: "this is a comment")
        click_button("Save Comment")
        expect(page.current_path).to eq("/bookmarks")
        expect(page).to have_content("this is a comment")
    end
    
end