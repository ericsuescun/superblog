class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception
  	include SessionsHelper	#Se hace include aca para que esten disponibles por toda la App!
	
end
