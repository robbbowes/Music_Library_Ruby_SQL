require("pry-byebug")
require_relative("../models/artist.rb")
require_relative("../models/album.rb")

Artist.delete_all()
# Album.delete_all()

artist_1 = Artist.new({'name' => 'Knife In The Bush'})
artist_2 = Artist.new({'name' => 'Week 3 Turmoils'})
artist_1.save
artist_2.save

# Artist.all


pry.binding
nil
