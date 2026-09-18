class CreateEmployeeRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_requests do |t|
      t.integer  :user_id, null: false
      t.string   :request_type, null: false
      t.string   :status, null: false, default: 'pending'
      t.string   :subject
      t.text     :description
      t.date     :start_date
      t.date     :end_date
      t.decimal  :amount, precision: 10, scale: 2
      t.integer  :approver_id
      t.datetime :approved_at
      t.timestamps
    end

    add_index :employee_requests, :user_id
    add_index :employee_requests, :request_type
    add_index :employee_requests, :status
  end
end
