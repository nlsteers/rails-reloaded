User.create!(name: 'Nathaniel Steers',
             email: 'nathansteers@gmail.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: 'Inactive User',
             email: 'inactive@user.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: false,
             activated: false)

99.times do |n|
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  name = firstname + ' ' + lastname
  email_address = firstname + '.' + lastname + n.to_s
  puts 'Seeding ' + email_address
  email = "#{email_address}@testuser.com"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
