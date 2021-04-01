require 'user'
require 'database_helpers'

describe User do
    
    describe '.create' do
        
        it 'saves the user to the database and returns a user' do
            user = User.create(email: 'test@mail.com', password: 'password123')
            
            persisted_data = persisted_data(table: 'users', id: user.id)
            expect(user.id).to eq(persisted_data['id'])
            expect(user.email).to eq('test@mail.com')
        end

        it 'hashes the password using BCrypt' do
            expect(BCrypt::Password).to receive(:create).with('password123')
            User.create(email: 'email@mail.come', password: 'password123')
        end
        
    end

    describe '.find' do
        
        it 'finds a user given their id' do
            user = User.create(email: 'test@email.com', password: 'password123')
            found_user = User.find(id: user.id)
            expect(found_user.id).to eq(user.id)
            expect(found_user.email).to eq(user.email)
        end

    end

    describe '#initialize' do
        
        it 'is initialized with an id and email' do
            user = User.new(id: 1, email: 'test@mail.com')
            expect(user.id).to eq(1)
            expect(user.email).to eq('test@mail.com')
        end

    end


end