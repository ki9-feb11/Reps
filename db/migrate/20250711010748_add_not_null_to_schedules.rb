class AddNotNullToSchedules < ActiveRecord::Migration[6.1]
  def change
    change_column_null :schedules, :title, false
    change_column_null :schedules, :date, false
    change_column_null :schedules, :schedule_type, false
  end
end
