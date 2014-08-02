class User < ActiveRecord::Base

  validates :name, presence: true

  after_save :send_welcome_email, :if => proc { |l| l.confirmed_at_changed? && l.confirmed_at_was.nil? } 
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable,:omniauth_providers => [:facebook,:openid]
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
	  user = User.where(:provider => auth.provider, :uid => auth.uid).first
	  unless user
      #User.create won't work since it automatically sets the country
	    user = User.new(name:auth.extra.raw_info.name,
	                         provider:auth.provider,
	                         uid:auth.uid,
	                         email:auth.info.email,
	                         password:Devise.friendly_token[0,20]
	                         )
     
     #user.currency_id=Currency.first.id if user.currency_id.blank?
    
     user.skip_confirmation! 

     user.save

    UserMailer.welcome(user).deliver  

	  end
	  user
	end


	
  def self.new_with_session(params, session)
    
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      
      end

   

    end
  end

  def send_welcome_email
    unless provider
      UserMailer.welcome(self).deliver  
    end
  end
end
