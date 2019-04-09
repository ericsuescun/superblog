class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  

  validates :user_id, presence: true	#This is related to the valid? method used in tests
  validates :content, presence: true, length: { maximum: 140 }

  mount_uploader :picture, PictureUploader	#This is the way for telling CarrierWave to relate the micropost model with the image uploader. I HAD to STOP de SPRING with spring stop in the command line. Apparently this sotware didnt let to initialize the error suite and an ERROR showed up. On the other hand, this very line had to be put AFTER de validates in order to clear failures in the tests too.

  validate  :picture_size	#The singular "validate" is because this is a custom validation, not a Rails standard validation which uses plural "validates"

  private

  	# Validates the size of an uploaded picture.
  	def picture_size
    	if picture.size > 5.megabytes
      		errors.add(:picture, "should be less than 5MB")
    	end
  	end

end
