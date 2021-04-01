describe "signing in", type: :feature do
    
    it 'has a sign in form' do
        visit '/session/new'
        expect(page).to have_field('email')
        expect(page).to have_field('password')
        expect(page).to have_button('Sign In')
    end

    it 'displays the user email on correct sign in' do
        User.create(email: 'mail@mail.com', password: 'password123')
        visit '/session/new'
        fill_in('email', with: 'mail@mail.com')
        fill_in('password', with: 'password123')
        click_button('Sign In')
        expect(page.current_path).to eq('/bookmarks')
        expect(page).to have_content("Welcome, mail@mail.com")
    end

    it 'displays an error message if the email is incorrect' do
        visit '/session/new'
        fill_in('email', with: 'mail@mail.com')
        fill_in('password', with: 'password123')
        click_button('Sign In')
        expect(page).to have_content('Please check your email or password')
    end

    it 'displays an error message if the password is incorrect' do
        User.create(email: 'mail@mail.com', password: 'password123')
        visit '/session/new'
        fill_in('email', with: 'mail@mail.com')
        fill_in('password', with: 'wrong password')
        click_button('Sign In')
        expect(page).to have_content('Please check your email or password')
    end

end