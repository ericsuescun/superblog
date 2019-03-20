class User < ApplicationRecord
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50}
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i   #Ese no tiene validacion de ".."
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }	#valid? adquiere un nuevo criterio: uniqueness, ademas se le pide que sea insensible a Case
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
end
