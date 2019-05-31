# create the basic classes to fill
User.delete_all
Station.delete_all
Selection.delete_all 

10.times do |user|
     user = User.create(name: Faker::Name.name, favorite_genre: Faker::Music.genre)
 end

100.times do |station|
    station = Station.create(name: "#{Faker::Alphanumeric.alphanumeric 4}, the #{Faker::Verb.base.capitalize}",
     host:"DJ #{Faker::Name.first_name}", genre: Faker::Music.genre)
end

10.times do |selection|
    selection = Selection.create(user_id:rand(1..10), station_id: rand(1..100))
end






