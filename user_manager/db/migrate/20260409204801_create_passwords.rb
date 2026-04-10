class CreatePasswords < ActiveRecord::Migration[8.1]
  def change
    create_table :passwords do |t|
      t.string :password_hash
      t.boolean :active
      t.datetime :active_start
      t.datetime :active_end

      t.timestamps
    end
  end
end
