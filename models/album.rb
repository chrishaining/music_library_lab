require('pg')
require_relative('../db/sql_runner')

class Album

attr_accessor :title, :genre
attr_reader :id, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save
    sql = "
    INSERT INTO albums
    (title, genre, artist_id)
    VALUES
    (
      $1, $2, $3
    )
    RETURNING *
    "
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

def Album.all
  sql = "SELECT * FROM albums"

  all_albums = SqlRunner.run(sql)
  return all_albums.map { |album| Album.new(album)}

end

def artist #this is a helper method
  sql = "
  SELECT * FROM artists
  WHERE id = $1"
  values = [@artist_id]
  results = SqlRunner.run(sql, values)
  artist_info = results[0]
  artist = Artist.new(artist_info)
  return artist.name
end


  #FINAL END
end
