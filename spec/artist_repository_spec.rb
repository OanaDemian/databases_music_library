 require 'artist'
 require 'artist_repository'
 require 'reseed_music_library_db'
 RSpec.describe ArtistRepository do
   
  describe ArtistRepository do
    before(:each) do 
      reseed_tables
    end

    it 'returns the list of artists' do 
      repo = ArtistRepository.new
      artists = repo.all
      expect(artists.length).to eq (4)
      expect(artists[0].id).to eq '1' #=> '1'
      expect(artists[0].name).to eq "Pixies" #=> 'Pixies'
      expect(artists[0].genre).to eq "Rock" #=> 'Rock'
    end

    it 'creates a new artist' do
      repo = ArtistRepository.new
      artist = Artist.new
      artist.name = 'Vama'
      artist.genre = 'Pop'
      repo.create(artist)
      last_artist = repo.all[-1]
      expect(last_artist.name).to eq 'Vama'
      expect(last_artist.genre).to eq 'Pop'
    end

    it 'deletes an artist' do
      repo = ArtistRepository.new
      id_to_delete = 1
      repo.delete(id_to_delete)
      all_artists = repo.all
      expect(all_artists.length).to eq 3
      expect(all_artists.first.id).to eq '2'
    end

    it 'deletes the two artists' do
      repo = ArtistRepository.new
      repo.delete(1)
      repo.delete(2)
      all_artists = repo.all
      expect(all_artists.length).to eq 2
    end

    it 'updates an artist with new values' do
      repo = ArtistRepository.new
      artist = repo.find(1)
      artist.name = 'Something else'
      artist.genre = 'Disco'
      repo.update(artist)
      updated_artist = repo.find(1)
      expect(updated_artist.name).to eq 'Something else'
      expect(updated_artist.genre).to eq 'Disco'

    end

    it 'updates an artist with new name only' do
      repo = ArtistRepository.new
      artist = repo.find(1)
      artist.name = 'Something else'
      repo.update(artist)
      updated_artist = repo.find(1)
      expect(updated_artist.name).to eq 'Something else'
      expect(updated_artist.genre).to eq 'Rock'
    end
 end
end