require("pg")
require_relative("../db/sql_runner")
require_relative("./artist.rb")

class Album

  attr_accessor(:name)
  attr_reader(:id)

  def initialize( album_details )
    @id = album_details["id"].to_i() if album_details["id"]
    @name = album_details["name"]
    @genre = album_details["genre"]
    @artist_id = album_details["artist_id"]
  end

  def save
    sql = '
      INSERT INTO albums (
        name,
        genre
      )'

  end



end
