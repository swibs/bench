class CreateRepairqs < ActiveRecord::Migration[5.0]
  def change
    create_table :repairqs do |t|
      t.string :name
      t.string :server
      t.string :location
      t.string :default_login
      t.string :default_pin

      t.timestamps
    end
  end
end
