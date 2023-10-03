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
    name: 'Class 40' },
]

puts 'Cleaning the database'

Race.destroy_all
Boat.destroy_all

puts 'Creating races'

race = Race.new(
  name: 'Transat Jacques Vabre',
  year: 2023,
  starting_date: '29/10/2023'
)

race.categories = ['Ultim', 'IMOCA', 'Ocean Fifty', 'Class 40']
race.save!

puts 'Creating races done'

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
    case category[:name]
    when 'Ultim'
      boat.category = [category[:name], 'logo-ultim.jpg']
    when 'IMOCA'
      boat.category = [category[:name], 'logo-imoca.jpg']
    when 'Ocean Fifty'
      boat.category = [category[:name], 'logo-of.jpg']
    when 'Class 40'
      boat.category = [category[:name], 'logo-c40.jpg']
    end
    boat.race = Race.last
    boat.save!
  end
end

puts 'Creating boats done'
