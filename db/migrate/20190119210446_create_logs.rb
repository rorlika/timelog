class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :hours
      t.timestamp :log_date

      t.timestamps
    end
  end
end
