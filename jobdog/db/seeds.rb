
users = [
  {email: "sterling@isis.org", first_name: "Sterling", last_name: "Archer", input_location: "New York, NY"},
  {email: "lana@isis.org", first_name: "Lana", last_name: "Kane", input_location: "New York, NY"},
  {email: "malory@isis.org", first_name: "Malory", last_name: "Archer", input_location: "New York, NY"},
  {email: "woodhouse@hotmail.com", first_name: "Woodhouse", input_location: "New York, NY"},
  {email: "cheryl@isis.org", first_name: "Cheryl", last_name: "Tunt", input_location: "New York, NY"}, 
  {email: "doctor@isis.org", first_name: "Doctor", last_name: "Krieger", input_location: "New York, NY"},
  {email: "brian@example.com", first_name: "Brian", last_name: "Holmes", input_location: "Nashua, NH"}
]

input_locs = [
  "131 Clinton St, Hoboken, NJ", 
  "770 Broadway, New York, NY",
  "41 W 40th St, New York, NY",
  "167 W 74th St, New York, NY",
  "513 W 54th St, New York, NY 10019",
  "30 Rockefeller Center, New York, NY",
  "375 3rd Ave, New York, NY ",
  "333 Park Ave, New York, NY",
  "445 Graham Ave, Brooklyn, NY",
  "Central Park, New York, NY",
  "Bronx Zoo, New York, NY", 
  "Staten Island Zoo, Staten Island, NY",
  "95 Prospect Park W, Brooklyn, NY",
  "Coney Island, Brooklyn, NY",
  "502 Washington St, Hoboken, NJ",
  "62 Newark St, Hoboken, NJ",
  "338 Bloomfield St, Hoboken, NJ",
  "201 Main St, Nashua, NH",
  "101 Factory St, Nashua, NH",
  "4 Sunapee St, Nashua, NH",
  "139 Daniel Webster Highway, Nashua, NH",
  "70 E Pearl St, Nashua, NH",
  "133 Main St, Nashua, NH",
  "201 Route 111, Hampstead, NH",
  "10 Main St, Hampstead, NH"
  ]

job_titles = [
  "deliver a package", 
  "take care of a thing", 
  "make me a sandwich", 
  "go see a guy about a horse", 
  "pickup a suitcase of money", 
  "walk my dog",
  "fetch me my brown pants",
  "put together ikea furniture",
  "fold my laundry",
  "drive my mother to the airport",
  "water my garden",
  "cancel all my appointments",
  "exorcise the demons from my possessed neighbor", 
  "teach me how to dougie"
]

job_descriptions = [
  "My name is Maximus Decimus Meridius, commander of the Armies of the North, General of the Felix Legions and loyal servant to the TRUE emperor, Marcus Aurelius. Father to a murdered son, husband to a murdered wife. And I will have my vengeance, in this life or the next.",
  "I address you tonight not as the President of the United States, not as the leader of a country, but as a citizen of humanity. We are faced with the very gravest of challenges. The Bible calls this day 'Armageddon' - the end of all things. And yet, for the first time in the history of the planet, a species has the technology to prevent its own extinction.",
  "Fight and you may die. Run and you will live at least awhile. And dying in your bed many years from now, would you be willing to trade all the days from this day to that for one chance, just one cahnce, to come back here as young men and tell our enemies that they may take our lives but they will never take our freedom!",
  "Great moments... are born from great opportunity. And that's what you have here, tonight, boys. That's what you've earned here tonight. One game. If we played 'em ten times, they might win nine. But not this game. Not tonight. Tonight, we skate with them. Tonight, we stay with them. And we shut them down because we can! Tonight, WE are the greatest hockey team in the world. You were born to be hockey players. Every one of you. And you were meant to be here tonight. This is your time. Their time is done. It's over. I'm sick and tired of hearing about what a great hockey team the Soviets have. Screw 'em. This is your time. Now go out there and take it.",
  "Bunch of tough guys. You look like a bunch of fifth grade sissies after a  cat fight. You got anger? Thats good, you going to need it. Son, you got aggression? Thats even better. You going to need that to. But any little two year old child can throw a fit. Football is about controlling that anger. Harnissing that aggression into a team effort to achieve perfection. Some coaches cut a player if they think he's not up to snuff, when they think he's hurting the team. This is a public school program. I will never, ever cut a player who comes out to play for me, but when you put that uniform on, that titan uniform, you better come to work. We will be perfect in every aspect of the game. You drop a pass, you run a mile. You miss a blocking assignment, you run a mile. You fumble the football and I will break my foot off in your john-brown hind parts, and then, you will run a mile. Perfection! . . . Let's go to work. "
]

categories = ["delivery", "handyman", "cooking", "creative", "tech", "other"]
  

users.each do |user|
  u = User.new(email: user[:email], password: "1234")
  u.build_profile(user.reject{ |k, v| k == :email })
  u.save!
end

User.all.each do |user|
  2.times do 
    user.jobs.create!(title: job_titles.sample, 
      input_location: input_locs.sample, 
      complete_by: Time.now + rand(30), 
      description: job_descriptions.sample,
      category: categories.sample
      )
  end
end









