class User < ApplicationRecord

	attr_accessor :remember_token, :activation_token, :reset_token
	before_save   :downcase_email
	before_create :create_activation_digest

	validates :name,  presence: true, length: { maximum: 50 }
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i   #Ese no tiene validacion de ".."
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }	#valid? adquiere un nuevo criterio: uniqueness, ademas se le pide que sea insensible a Case
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	# Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token.
	def User.new_token				#Because it doesn't work with de DB, its made as a class method
	  	SecureRandom.urlsafe_base64	#This comes already in Ruby so we can use it as much as we can
	end

	def remember 	#As in the password hash procedure a "password" hash is needed, but we have to write it down ourselves
	    self.remember_token = User.new_token	#self is used so remember_token doesn't become a local variable, but a class variable of User (user.remember_token)
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest.
	# def authenticated?(remember_token)
	# 	return false if remember_digest.nil?
	#     BCrypt::Password.new(remember_digest).is_password?(remember_token)
	# end

	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")	#Remember the metacprogramming: Send is a method for sending commands or messages, in this case, the argument is interpolated and can be activation or remember.
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)	#Comparison method by Bcrypt
	end

	# Forgets a user.
	def forget
	    update_attribute(:remember_digest, nil)
	end

	# Activates an account.
	def activate
	    # update_attribute(:activated,    true)
	    # update_attribute(:activated_at, Time.zone.now)
	    update_columns(activated: true, activated_at: Time.zone.now)
	end

	# Sends activation email.
	def send_activation_email
	    UserMailer.account_activation(self).deliver_now
	end

	# Sets the password reset attributes.
	def create_reset_digest
	    self.reset_token = User.new_token
	    update_attribute(:reset_digest,  User.digest(reset_token))
	    update_attribute(:reset_sent_at, Time.zone.now)
	end

	# Sends password reset email.
	def send_password_reset_email
	    UserMailer.password_reset(self).deliver_now
	end

	# Returns true if a password reset has expired.
	def password_reset_expired?
	  reset_sent_at < 2.hours.ago
	end

	private

	    # Converts email to all lower-case.
	    def downcase_email
	      email.downcase!
	    end

	    # Creates and assigns the activation token and digest.
	    def create_activation_digest
	      self.activation_token  = User.new_token
	      self.activation_digest = User.digest(activation_token)
	    end

end
