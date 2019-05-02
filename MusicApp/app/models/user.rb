class User < ApplicationRecord
    validates :email, presence: true
    validates :session_token, presence: true, unique: true
    validates :password_digest, presence: true

    after_initialize :ensure_session_token
    
    attr_reader :password
    
    def self.find_by_credentials (email, password)
        user = User.find_by(email: email, password: password)
        
        return nil unless user && user.is_password?(password)
        user
    end
    
    def self.generate_session_token
        SecureRandom::ursafe_base64
    end

    def reset_session_token!
        self.update!(session_token: self.class.generate_session_token)
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    def is_password?(password)
        bcrypt_password = BCrypt::Password(self.password_digest)
        bcrypt_password.is_password?(password)
    end

    def password=(password)
        @password = password
        
        self.password_digest = BCrypt::Password.create(password)
    end


end