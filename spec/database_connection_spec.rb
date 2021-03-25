require 'database_connection'

describe DatabaseConnection do

    let(:subject) { DatabaseConnection }
    
    describe ".setup" do
        
        it 'connects to the database given in the argument' do
            expect(PG).to receive(:connect).with(dbname: 'bookmark_manager_test')
            subject.setup(dbname: "bookmark_manager_test")
        end

        it 'has a consistent connection to the database' do
            connection = subject.setup(dbname: 'bookmark_manager_test')
            expect(subject.connection).to eq(connection)
        end

    end

    describe ".query" do
        
        it 'executes a query via PG' do
            connection = subject.setup(dbname: 'bookmark_manager_test')
            expect(connection).to receive(:exec).with('SELECT * FROM bookmarks')
            subject.query('SELECT * FROM bookmarks')
        end

    end

end