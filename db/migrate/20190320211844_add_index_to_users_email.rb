class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
  	add_index :users, :email, unique: true		#Esta accion en ls DB no fue predeterminada por el modelo, por lo que toca escribir lo que se necesita que haga
  end
end
