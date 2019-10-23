unless User.count > 0
  me = User.create!(email: 'dorlandimort@gmail.com', password: 'temporal', password_confirmation: 'temporal',
                    first_name: 'Orlando Giovanni', last_name: 'Martínez', mother_last_name: 'Dionisio')
  karimnot = User.create!(email: 'karimnot@gmail.com', password: 'temporal', password_confirmation: 'temporal',
                          first_name: 'Daniel Karim', last_name: 'Ricardez', mother_last_name: 'Ortíz')

  me.add_role :SUPER
  karimnot.add_role :SUPER
end