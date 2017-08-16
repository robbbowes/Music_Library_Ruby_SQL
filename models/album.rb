require("pg")
require_relative("../db/sql_runner")
require_relative("./artist.rb")

class Album

  attr_accessor(:name)
  attr_reader(:id)

  def initialize( album_details )
    @id = album_details["id"].to_i()
    @name = album_details['name']
    @genre = album_details['genre']
    @artist_id = album_details['artist_id']
  end

  def save
    sql = '
      INSERT INTO albums (
        name,
        genre
      ) VALUES (
        $1, $2
      )
      RETURNING *;'
    values = [@name, @genre]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i()
  end

  def Album.show_all
    sql = 'SELECT * FROM albums;'
    results = SqlRunner.run(sql)

    albums = results.map {|album| Album.new(album)}
    return albums
  end

  def Album.delete_all
    db = PG.connect({ dbname: 'music_library', host: 'localhost'})
    sql = 'DELETE FROM albums;'
    db.exec(sql)
    db.close()
  end

  def artist
    sql = 'SELECT name FROM artists WHERE id = $1;'
    results_array = SqlRunner.run(sql, [@artist_id])
    artist = results_array.map {|artist_hash| Album.new(artist_hash)}
    return artist
  end

  def update
    sql = 'UPDATE albums SET (
      name,
      genre
      ) = (
      $1, $2
      )
      WHERE id = $3;'
    values = [@name, @genre, @id]
    results = SqlRunner.run(sql, values)
  end



end
