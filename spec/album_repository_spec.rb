'file: spec/album_repository_spec.rb'
require 'album.rb'
require 'album_repository.rb'
RSpec.describe AlbumRepository do
def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  it 'returns the list of albums' do 
    repo = AlbumRepository.new
    album = repo.all
    expect(album.length).to eq (3)
    expect(album[0].title).to eq 'Doolittle' #=> '1'
    expect(album[0].release_year).to eq "1989" #=> '1989'
    expect(album[0].artist_id).to eq '1' #=> '1'
    expect(album[1].title).to eq 'Super Trouper' #=> 'Super Trouper'
    expect(album[1].release_year).to eq "1980" #=> '1980'
    expect(album[1].artist_id).to eq '2' #=> '2'
  end

  it 'finds a specific album by id' do
    repo = AlbumRepository.new
    album = repo.find(3)
    expect(album.title).to eq "Surfer Rosa"
    expect(album.release_year).to eq "1988"
    expect(album.artist_id).to eq "1"
  end

  it 'updates a specific album by id' do
    repo = AlbumRepository.new
    album = repo.find(1)
    album.release_year = 2001
    updated_album = repo.update(album)
    expect(repo.find(1).release_year).to eq '2001'
    expect(repo.find(1).title).to eq 'Doolittle'
    album.release_year = 1989
    updated_album = repo.update(album)
    expect(repo.find(1).release_year).to eq '1989'
    expect(repo.find(1).artist_id).to eq '1' 
  end

  it 'creates a new album' do
    repo = AlbumRepository.new

    album = Album.new

    album.title = 'Trompe le Monde '
    album.release_year = '1991'
    album.artist_id = '1'

    repo.create(album) #=> nil
    repo.all
    last_album = repo.all.last

    expect(last_album.id).to eq '4'
    expect(last_album.title).to eq 'Trompe le Monde '
    expect(last_album.release_year).to eq '1991'
    expect(last_album.artist_id).to eq '1'
  end
end
end