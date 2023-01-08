def reseed_tables
    seed_artists_sql = File.read('spec/seeds_artists.sql')
    seed_albums_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test'})
    connection.exec(seed_artists_sql)
    connection.exec(seed_albums_sql)
  end