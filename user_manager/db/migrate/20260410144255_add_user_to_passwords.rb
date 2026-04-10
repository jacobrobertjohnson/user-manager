class AddUserToPasswords < ActiveRecord::Migration[8.1]
  def change
    add_reference :passwords, :user, null: false, foreign_key: { on_delete: :cascade }
  end
end
