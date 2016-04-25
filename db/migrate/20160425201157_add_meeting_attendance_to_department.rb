class AddMeetingAttendanceToDepartment < ActiveRecord::Migration
  def change
        
        add_column :departments, :meeting_attendance, :string
  end
end
