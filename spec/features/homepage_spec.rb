describe "The homepage", type: :feature do
    
    it 'contains the title' do
        visit '/'
        expect(page).to have_content("Bookmark Manager")
    end

end