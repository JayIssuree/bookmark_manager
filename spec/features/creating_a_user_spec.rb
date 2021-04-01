describe "creating a new user", type: :feature do

    it "has a sign up form" do
        visit '/users/new'
        expect(page).to have_field("email")
        expect(page).to have_field("password")
        expect(page).to have_button("Submit")
    end

    it "displays the username on a successful sign up" do
        visit '/users/new'
        fill_in('email', with: 'test@example.com')
        fill_in('password', with: 'password123')
        click_button('Submit')
    
        expect(page.current_path).to eq('/bookmarks')
        expect(page).to have_content "Welcome, test@example.com"
    end
    
end