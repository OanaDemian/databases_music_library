```ruby
artist = Artist.new

artist.name # 'Pixies'
artist.genre # 'Rock'

artist_repository = ArtistRepository.new

# Select all artists

#SQL: SELECT id, name, genre FROM artists;
# Return an array Artist objects (hashes) 

artist_repository.find_all_artists

# Select a single artist
#SQL: SELECT id, name, genre FROM artists WHERE id = '1';
#  Return a single Artist object
artist_repository.find(1)

# delete a single artist
# SQL DELETE FROM artists WHERE name = 'Pixies'
artist_repository.delete(artist_name)

new_artist = Artist.new
new_artist.name = 'Radiohead'
#...
#SQL INSERT INTO artists ...

artist_repository.create(new_artist)
```