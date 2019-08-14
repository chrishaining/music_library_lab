require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "
    INSERT INTO artists
    (name)
    values($1)
    RETURNING *
    "
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

def Artist.all
sql = "SELECT * FROM artists"

all_artists = SqlRunner.run(sql)
return all_artists.map { |artist| Artist.new(artist)}
end

def album #this is a helper method
  sql = "
  SELECT * FROM albums
  WHERE artist_id = $1"
  values = [@id]
  albums_info = SqlRunner.run(sql, values)
  all_albums = albums_info.map { |album| Album.new(album) }
  return all_albums
end


  #FINAL END
end
