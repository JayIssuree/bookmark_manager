class User

    def self.create(email:, password:)
        result = DatabaseConnection.query("INSERT INTO users (email, password) VALUES ('#{email}', '#{password}') RETURNING id, email, password")
        User.new(
            id: result[0]['id'],
            email: result[0]['email'],
            password: result[0]['password']
        )
    end

    def self.find(id:)
        return nil if id == nil
        result = DatabaseConnection.query("SELECT * FROM users WHERE id = #{id}")
        User.new(
            id: result[0]['id'],
            email: result[0]['email'],
            password: result[0]['password']
        )
    end


    attr_reader :id, :email, :password

    def initialize(id:, email:, password:)
        @id = id
        @email = email
        @password = password
    end

end