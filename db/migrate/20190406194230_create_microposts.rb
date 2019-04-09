class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]	#Later we expect to bring info based on the user and the timestamp of creation (as in Twitter). By putting it as an array, Rails uses both keys for the search!
  end
end
