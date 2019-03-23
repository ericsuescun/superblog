class SessionsController < ApplicationController

  def new

  end

  def create
  	@user = User.find_by(email: params[:session][:email].downcase)	#Busca el ususario de la DB por email
  	if @user && @user.authenticate(params[:session][:password])	#Si el usuario que encontró fue el mismo que validó por authenticate y el password, el usuario es auténtico
      log_in @user   #Usa el método SESSION de Rails para guardar el id de ususario
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      #remember @user   #Se implementa ya el método remember de modo que el usuario sea recordado de una vez
      redirect_to @user  #Rails automáticamente busca la ruta del user (user_url(user))
  	else
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
