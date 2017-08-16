require("pry-byebug")
require_relative("../models/artist.rb")
require_relative("../models/album.rb")

Artist.delete_all()
Album.delete_all()

artist_1 = Artist.new({'name' => 'Knife In The Bush'})
artist_2 = Artist.new({'name' => 'Week 3'})
artist_1.save
artist_2.save

album_1 = Album.new({'name' => 'Turmoils', 'genre' => 'Prog Rock', 'artist_id' => artist_1.id})
album_1.save


pry.binding
nil
