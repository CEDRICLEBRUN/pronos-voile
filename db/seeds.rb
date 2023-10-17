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

puts 'Creating users'

first_user = User.new(
  email: 'cedric@gmail.com',
  password: 'cedric',
  first_name: 'Cédric',
  last_name: 'LE BRUN',
  username: 'Cé'
)
photoavatar = URI.open('https://res.cloudinary.com/dciokrtia/image/upload/v1683299445/development/qpna49jt3a8ff4sfmudt46uwqeda.jpg')
first_user.avatar.attach(io: photoavatar, filename: 'avatar.png', content_type: 'image/png')
first_user.save!

second_user = User.new(
  email: 'tibopino@gmail.com',
  password: 'tibopino',
  first_name: 'Thibaut',
  last_name: 'PINOT',
  username: 'Tibopino'
)
second_user.save!

third_user = User.new(
  email: 'wawa@gmail.com',
  password: 'secret',
  first_name: 'Warren',
  last_name: 'BARGUIL',
  username: 'Wawa'
)
third_user.save!

puts 'Creating users done'

#############################################################################

puts 'Creating crews'


first_crew = Crew.new(
  name: 'Chalalalala',
  )
first_crew.user = first_user
firstlogo = URI.open('https://res.cloudinary.com/dciokrtia/image/upload/v1683299445/development/qpna49jt3a8ff4sfmudt46uwqeda.jpg')
first_crew.logo.attach(io: firstlogo, filename: 'logo.png', content_type: 'image/png')
first_crew.save!

second_crew = Crew.new(
  name: 'GFDJ',
)
second_crew.user = second_user
secondlogo = URI.open('https://res.cloudinary.com/dciokrtia/image/upload/v1688115889/production/fwogzje5xrsatoksmt7ufqxpn6ts.jpg')
second_crew.logo.attach(io: secondlogo, filename: 'logo.png', content_type: 'image/png')
second_crew.save!

third_crew = Crew.new(
  name: 'Arkea',
)
third_crew.user = third_user
thirdlogo = URI.open('https://res.cloudinary.com/dciokrtia/image/upload/v1688153937/development/twya9iabwi2titkptsg3odk9n3f1.jpg')
third_crew.logo.attach(io: thirdlogo, filename: 'logo.png', content_type: 'image/png')
third_crew.save!

puts 'Creating crews done'

#############################################################################

puts 'Creating admissions'

first_admission = Admission.new()
first_admission.crew = first_crew
first_admission.user = second_user
first_admission.save!

second_admission = Admission.new()
second_admission.crew = first_crew
second_admission.user = third_user
second_admission.save!

first_admission = Admission.new()
first_admission.crew = second_crew
first_admission.user = first_user
first_admission.save!

puts 'Creating admissions done'

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
    case category[:name]
    when 'Ultim'
      boat.category = category[:name]
    when 'IMOCA'
      boat.category = category[:name]
    when 'Ocean Fifty'
      boat.category = category[:name]
    when 'Class 40'
      boat.category = category[:name]
    end
    boat.race = Race.last
    boat.save!
  end
end

puts 'Creating boats done'
