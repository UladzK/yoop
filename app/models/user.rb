class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
  								:name, :provider, :uid

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(
                        name: "#{auth.info["first_name"]}#{auth.info["last_name"]}",
                        provider: auth["provider"],
                        uid: auth["uid"],
                        email: auth["info"]["email"],
                        password: Devise.friendly_token[0,20]
                        )
      user.save
    end
    user
  end

  def self.find_for_google_oauth2(auth, signed_in_resource=nil)
    user = User.where(:email => auth["info"]["email"]).first
    unless user
      user = User.create(
      									name: auth["info"]["name"],
						            email: auth["info"]["email"],
						            password: Devise.friendly_token[0,20]
						            )
    end
    user
end  						
end
