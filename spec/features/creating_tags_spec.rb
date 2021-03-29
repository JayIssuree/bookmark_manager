describe "creating tags", type: :feature do
    
    it "has a button to create a tag" do
        visit '/bookmarks'
        expect(page).to have_content("Tags:")
        expect(page).to have_button("Create New Tag")
    end

    it "clicking the button leads to a form for creating a new tag" do
        visit '/bookmarks'
        click_button("Create New Tag")
        expect(page.current_path).to eq('/tags/new')
        expect(page).to have_field("tag_name")
        expect(page).to have_button("Save Tag")
    end

    it "the created tag appears on the homepage" do
        visit '/bookmarks'
        click_button("Create New Tag")
        fill_in("tag_name", with: "Tag example 1")
        click_button("Save Tag")
        expect(page.current_path).to eq('/bookmarks')
        expect(page).to have_button("Tag example 1")
    end

end