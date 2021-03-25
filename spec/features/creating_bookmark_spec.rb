describe "creating a bookmark", type: :feature do
    
    it "has a link to the create bookmark page" do
        visit '/'
        expect(page).to have_button('Add Bookmark')
    end

    it "contains a form to add a bookmark" do
        visit '/'
        click_button 'Add Bookmark'
        expect(page).to have_field('name')
        expect(page).to have_field('url')
        expect(page).to have_button('Save Bookmark')
    end

    it "adds the bookmark to the database which is available to see" do
        visit '/'
        click_button 'Add Bookmark'
        fill_in 'name', with: 'test'
        fill_in 'url', with: 'https://www.testurl.com'
        click_button 'Save Bookmark'
        expect(page).to have_link("test", :href => "https://www.testurl.com")
    end

end