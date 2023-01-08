'lib/album_repository.rb'
require_relative './album'
class AlbumRepository

  # Selecting all albums
  # No arguments
  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])
    albums = []
    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']
      albums << album
    end
     return albums
  end
  # Gets a single album by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;
    sql = "SELECT id, title, release_year, artist_id FROM albums WHERE id =$1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
    album = Album.new
    album.id = record['id']
    album.title = record['title']
    album.release_year = record['release_year']
    album.artist_id = record['artist_id']
    return album
  end

  def update(album)
     sql = "UPDATE albums SET title = '#{album.title}', release_year = '#{album.release_year}', artist_id = '#{album.artist_id}' WHERE id = '#{album.id}';"
     result_set = DatabaseConnection.exec_params(sql, [])
     return nil
  end

  def create(album)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES($1, $2, $3);'
    sql_param = [album.title, album.release_year, album.artist_id]
    result_set = DatabaseConnection.exec_params(sql, sql_param)
    return nil
  end
end
