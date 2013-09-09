class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :provider, :uid

  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6, :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      chars = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
      passwd = Array.new(12, " ").collect{ chars[ rand( chars.size ) ] }.join  
      user = User.create(
                        username:"#{auth.info["first_name"]}#{auth.info["last_name"]}",
                        provider:auth["provider"],
                        uid:auth["uid"],
                        email:auth["info"]["email"],
                        password:passwd
                        )
      user.save
    end
    user
  end

  def self.find_for_google_oauth(auth, signed_in_resource = nil)    
    user = User.where(:provider => auth.provider,:uid => auth.uid).first
    unless user
      chars = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
      passwd = Array.new(12, " ").collect{ chars[ rand( chars.size ) ] }.join
      user = User.create(
                         provider:'open_id',
                         email:auth['email'],
                         password:passwd
                         )
    end
    user
  end

end