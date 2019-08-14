require('pry-byebug')
require_relative('./models/artist')
require_relative('./models/album')

artist1 = Artist.new( { 'name' => 'Jim Morrison'} )
artist2 = Artist.new( { 'name' => 'David Bowie'} )
artist3 = Artist.new( { 'name' => 'Jimi Hendrix'} )
artist4 = Artist.new( { 'name' => 'Joni Mitchell'} )
artist5 = Artist.new( { 'name' => 'Buddy Holly'} )

artist1.save()
artist2.save()
artist3.save()
artist4.save()
artist5.save()

album1 = Album.new( {'title' => 'Poems', 'genre' => 'Rock', 'artist_id' => artist1.id})
album2 = Album.new( {'title' => 'Ziggy', 'genre' => 'Rock', 'artist_id' => artist2.id})
album3=Album.new( {'title' => 'The Jimi Hendrix Experience', 'genre' => 'Guitar', 'artist_id' => artist3.id})
album4=Album.new( {'title' => 'Big Yellow Taxi', 'genre' => 'Folk', 'artist_id' => artist4.id})
album5=Album.new( {'title' => 'Greatest Hits', 'genre' => 'Rock n roll', 'artist_id' => artist5.id})
album6=Album.new( {'title' => 'Poems 2', 'genre' => 'Rock n roll', 'artist_id' => artist1.id})

album1.save()
album2.save()
album3.save()
album4.save()
album5.save()
album6.save()

binding.pry
nil
