
user = User.create(name: 'testuser', email: 'testuser@test.com', password: '12345')
project = Project.create(name: 'Timelog', user: user)

5.times do |t|
  Log.create!(user: user, project: project, hours: t.to_i + 1,  log_date: Time.current + t.to_i.day)
end