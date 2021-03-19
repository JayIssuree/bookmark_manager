describe "The homepage", type: :feature do
    
    it 'greets the user' do
        visit '/'
        expect(page).to have_content("Hello World!")
    end

end