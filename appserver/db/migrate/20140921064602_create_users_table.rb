class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.datetime :next_alarm

      t.timestamps
    end

    add_index :users, :username
    add_index :users, :next_alarm
  end
end
