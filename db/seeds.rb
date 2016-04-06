# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

departments = [{:academic_unit_name => 'Performance Studies', :college => 'Liberal Arts', :state => '1'},
               {:academic_unit_name => 'Educational Administration and Human Resource Development', :college => 'Education and Human Development', :state => '1'},
               {:academic_unit_name => 'Biology', :college => 'Science', :state => '1'},
               {:academic_unit_name => 'English', :college => 'Liberal Arts', :state => '1'},
               {:academic_unit_name => 'Philosophy', :college => 'Liberal Arts', :state => '1'},
               {:academic_unit_name => 'Political Science', :college => 'Liberal Arts', :state => '1'},

  	 ]

departments.each do |department|
  Department.create!(department)
end