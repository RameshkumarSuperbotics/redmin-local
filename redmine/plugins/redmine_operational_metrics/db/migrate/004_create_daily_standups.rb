class CreateDailyStandups < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_standups do |t|
      t.string   :name, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.integer  :user_id, null: false
      t.timestamps
    end

    add_index :daily_standups, :user_id
  end
end
