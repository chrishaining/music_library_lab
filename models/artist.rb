require('pg')
require_relative('../db/sql_runner')
require_relative('album')
require('pry')


class Artist

  attr_reader :id, :name
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  #Creates a new record. The CREATE part of CRUD.
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

  #Shows all the records in artists. The READ part of CRUD.
  def Artist.all
    sql = "SELECT * FROM artists"

    all_artists = SqlRunner.run(sql)
    return all_artists.map { |artist| Artist.new(artist)}
  end

  #Shows all the albums linked to an artist. The READ part of CRUD.
  def album #this is a helper method
    sql = "
    SELECT * FROM albums
    WHERE artist_id = $1"
    values = [@id]
    albums_info = SqlRunner.run(sql, values)
    all_their_albums = albums_info.map { |album| Album.new(album) }
    return all_their_albums
  end

  #I DO NOT KNOW HOW TO DELETE WHEN ONE TABLE IS DEPENDENT ON ANOTHER TABLE
  #Methods to delete records. the DELETE part of CRUD.
  # def Artist.delete_all
  #   sql = "DELETE FROM artists"
  #   result = SqlRunner.run(sql)
  #   sql = "DELETE FROM artists"
  # end

  # def delete
  #   sql = "DELETE FROM artists WHERE id = $1"
  #   values = [@id]
  #   SqlRunner.run(sql, values)
  # end


  #Updates a record. The UPDATE part of CRUD. NOT WORKING - error message is /Users/user/codeclan_work/week_03/day_3/music_library_lab/models/artist.rb:62:in `async_prepare': ERROR:  source for a multiple-column UPDATE item must be a sub-SELECT or ROW() expression (PG::FeatureNotSupported)
  # LINE 4:     ($1)
  def update
    sql = "
    UPDATE artists
    SET name =
    ($1)
    WHERE id = $2
    RETURNING *
    "
    # values = [@id, @name]
    values = [@name, @id]
    result = SqlRunner.run(sql, values)
    updated_artist = Artist.new(result[0])
    return updated_artist
  end

  #updates file. the UPDATE of CRUD.
  def update()
    sql = "UPDATE artists
    SET
    name
    =
    (
      $1
    )
    WHERE id = $2
    RETURNING * "
    values = [@name, @id]
    result = SqlRunner.run(sql, values)
    updated_artist = Artist.new(result[0])
    return updated_artist
  end

  #Finds an artist by id.  The READ part of CRUD. TO REFACTOR USING SqlRunner
  def Artist.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results_array = SqlRunner.run(sql, values)
    return nil if results_array.first() == nil
    artist_hash = results_array[0]
    found_artist = Artist.new(artist_hash)
    return found_artist
  end

  def Artist.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #FINAL END
end
