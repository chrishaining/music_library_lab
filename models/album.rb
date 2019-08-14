require('pg')
require_relative('../db/sql_runner')
require_relative('artist')

class Album

attr_accessor :title, :genre
attr_reader :id, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

#Creates a new record. The CREATE part of CRUD.
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

#Shows all the records in albums. The READ part of CRUD.
def Album.all
  sql = "SELECT * FROM albums"

  all_albums = SqlRunner.run(sql)
  return all_albums.map { |album| Album.new(album)}

end

#Shows all the artists linked to an album. The READ part of CRUD.
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

#I DO NOT KNOW HOW TO DELETE WHEN ONE TABLE IS DEPENDENT ON ANOTHER TABLE
#Methods to delete records. the DELETE part of CRUD.
# def Album.delete_all
#   sql = "DELETE FROM albums"
#   result = SqlRunner.run(sql)
#   sql = "DELETE FROM albums"
# end

# def delete
#   sql = "DELETE FROM albums WHERE id = $1"
#   values = [@id]
#   SqlRunner.run(sql, values)
# end

#Finds an album by id.  The READ part of CRUD.
def Album.find(id)
  db = PG.connect({dbname: 'music_library', host: 'localhost'})
  sql = "SELECT * FROM albums WHERE id = $1"
  values = [id]
  db.prepare("find", sql)
  results_array = db.exec_prepared("find", values)
  db.close()
  return nil if results_array.first() == nil
  album_hash = results_array[0]
  found_album = Album.new(album_hash)
  return found_album
end

  #FINAL END
end
