# frozen_string_literal: true

class AddJobRoleAndDepartmentToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :job_role, :string
    add_column :users, :department, :string
    add_index :users, :job_role
    add_index :users, :department
  end
end
