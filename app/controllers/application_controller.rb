class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception
	
  	include SessionsHelper	#Se hace include aca para que esten disponibles por toda la App!

  	private
  		# Confirms a logged-in user.
  		def logged_in_user
  		  unless logged_in?
  		    store_location
  		    flash[:danger] = "Please log in."
  		    redirect_to login_url
  		  end
  		end
	
end
