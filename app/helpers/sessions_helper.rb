module SessionsHelper
	# Logs in the given user.
	def log_in(user)
		session[:user_id] = user.id
	end	#This helpers becomes availables in every view of this controller, but,
	  		#as we already included it in te Application Controller, then it becomes available through the entire app
	def current_user
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		end
	end

	def logged_in?
		!current_user.nil?
	end

	# Logs out the current user.
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end
end			


