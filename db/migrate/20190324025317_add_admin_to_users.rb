class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false	#El default FALSE es adecuado dejarlo explícito aunque por defecto todos los campos queden NIL.
  end
end
