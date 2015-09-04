class User < ActiveRecord::Base
    attr_accessor :password
    EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
    validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
    validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
    validates :password, :confirmation => true
    validates_length_of :password, :in => 6..20, :on => :create
    
    attr_accessible :username, :email, :password, :password_confirmation
    
    before_save :encrypted_password
    after_save :clear_password
    def encrypt_password
        if password.present?
            self.salt = BCrypt::Engine.generate_salt
            self.encrypt_password=BCrypt::Engine.hash_secret(password, salt)
        end
        def clear_password
            self.password = nil
        end
    end
    
    devise :database_authenticatable, :registerable,
           :reconverable, :rememberable, :trackable, :validatable
           
    has_many :conversations, :foreign_key => :sender_id
        
end
