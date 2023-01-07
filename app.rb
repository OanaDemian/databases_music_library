require_relative 'lib/album_repository'
require_relative 'lib/database_connection'
require_relative 'lib/album'



# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

album_repository = AlbumRepository.new
album = album_repository.all
album.each {|record| p record}
# album_1 = album_repository.find(1)
#  p album_1.title

#  album_1.title = 'Doolittle'
#  album_repository.update(album_1)
#  p album_1.title
# album_one = artist_repository.find(1)
# puts "BANNANAS ARE A THING"
# puts album_one.title
# album_one.title = 'Doolittle'
#  artist_repository.update(album_one)
# album_updated = artist_repository.find(1)
# puts album_updated.title
# artist_repository.update(album)
# end
