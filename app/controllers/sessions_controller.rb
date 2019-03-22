class SessionsController < ApplicationController

  def new

  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)	#Busca el ususario de la DB por email
  	if user && user.authenticate(params[:session][:password])	#Si el usuario que encontró fue el mismo que validó por authenticate y el password, el usuario es auténtico
      log_in user   #Usa el método SESSION de Rails para guardar el id de ususario
      redirect_to user  #Rails automáticamente busca la ruta del user (user_url(user))
  	else
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
