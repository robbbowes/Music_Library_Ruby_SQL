require("pg")
require_relative("../db/sql_runner")

class Artist

  attr_accessor(:name)
  attr_reader(:id)

  def initialize( artist_details )
    @id = artist_details["id"].to_i() if artist_details["id"]
    @name = artist_details["name"]
  end


  def save
    sql = '
      INSERT INTO artists
      (
        name
      ) VALUES (
        $1
      )
        RETURNING *;'
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i()
  end

  def Artist.show_all
    sql = 'SELECT * FROM artists;'
    results = SqlRunner.run(sql)

    artists = results.map do |artist_hash|
      Artist.new(artist_hash)
    end

    return artists
  end

  def Artist.delete_all
    db = PG.connect({ dbname: 'music_library', host: 'localhost'})
    sql = 'DELETE FROM artists;'
    db.exec(sql)
    db.close()
  end

  def album
    sql = 'SELECT * FROM albums WHERE id = $1;'
    results_array = SqlRunner.run(sql, [@album_id])
    album = results_array.map {|album_hash| Album.new(album_hash)}
    return album
  end

  def update
    sql = 'UPDATE artists SET (
      name
      ) = (
      $1
      )
      WHERE id = $2;'
    values = [@name, @id]
    results = SqlRunner.run(sql, values)
  end

end
