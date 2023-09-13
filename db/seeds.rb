require 'csv'
require 'open-uri'
require 'uri'

ultim = ['db/fixtures/ultim.csv', 'Ultim']
imoca = ['db/fixtures/imoca.csv', 'IMOCA']
ocean_fifty = ['db/fixtures/ocean_fifty.csv', 'Ocean Fifty']
class_fourty = ['db/fixtures/class_fourty.csv', 'Class 40']
categories = [ultim, imoca, ocean_fifty, class_fourty]

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
  CSV.foreach(category.first, headers: true, col_sep: ";") do |row|
    boat = Boat.new(
      name: row[0],
      first_skipper_name: row['first_skipper_name'],
      first_skipper_nationality: row['first_skipper_nationality'],
      second_skipper_name: row['second_skipper_name'],
      second_skipper_nationality: row['second_skipper_nationality']
    )
    boat.category = category.last
    boat.race = Race.last
    boat.save!
  end
end

puts 'Creating boats done'
