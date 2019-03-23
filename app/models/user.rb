class User < ApplicationRecord

	attr_accessor :remember_token	#This is a variable needed to hold the token for the login remember function

	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50}
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i   #Ese no tiene validacion de ".."
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }	#valid? adquiere un nuevo criterio: uniqueness, ademas se le pide que sea insensible a Case
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

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
	def authenticated?(remember_token)
		return false if remember_digest.nil?
	    BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forgets a user.
	def forget
	    update_attribute(:remember_digest, nil)
	end

end
