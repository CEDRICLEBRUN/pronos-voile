require 'csv'
require 'open-uri'
require 'uri'

categories = [
  { file_path: 'db/fixtures/ultim.csv',
    name: 'Ultim' },
  { file_path: 'db/fixtures/imoca.csv',
    name: 'IMOCA' },
  { file_path: 'db/fixtures/ocean_fifty.csv',
    name: 'Ocean Fifty' },
  { file_path: 'db/fixtures/class_fourty.csv',
    name: 'Class 40' }
]

puts 'Cleaning the database'

User.destroy_all
Race.destroy_all

#############################################################################

puts 'Creating race'

race = Race.new(
  name: 'Transat Jacques Vabre',
  year: 2023,
  starting_date: '29/10/2023'
)

race.categories = [{ logo_path: 'logo-ultim.jpg',
  name: 'Ultim' },
{ logo_path: 'logo-imoca.jpg',
  name: 'IMOCA' },
{ logo_path: 'logo-of.jpg',
  name: 'Ocean Fifty' },
{ logo_path: 'logo-c40.jpg',
  name: 'Class 40' }]
race.save!

puts 'Creating race done'

#############################################################################

puts 'Creating boats'

categories.each do |category|
  CSV.foreach(category[:file_path], headers: true, col_sep: ";") do |row|
    boat = Boat.new(
      name: row[0],
      first_skipper_name: row['first_skipper_name'],
      first_skipper_nationality: row['first_skipper_nationality'],
      second_skipper_name: row['second_skipper_name'],
      second_skipper_nationality: row['second_skipper_nationality']
    )
    boat.category = category[:name]
    boat.race = Race.last
    boat.save!
  end
end

puts 'Creating boats done'
