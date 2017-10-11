class CreateGroupMeBots < ActiveRecord::Migration[5.0]
  def change
    create_table :group_me_bots do |t|
      t.string :token
      t.string :bot_id
      t.string :name

      t.timestamps
    end
  end
end
