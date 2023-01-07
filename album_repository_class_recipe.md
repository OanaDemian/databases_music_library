Albums Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.



1. Design and create the Table
If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table albums

```sql

# EXAMPLE

Table: albums

Columns:
id | title | record_year | artist_id
2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES ('Doolittle', '1989', '1');
INSERT INTO albums (title,release_year, artist_id) VALUES ('Super Trouper', '1980', '2');
INSERT INTO albums (title,release_year, artist_id) VALUES ('Surfer Rosa', '1988', '1');

```
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 music_library_test < music_database.sql
psql -h 127.0.0.1 music_library_test < spec/seeds_{albums}.sql
``` 


3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.
```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)
class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end
```
4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.
```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)

class Album

  # Replace the attributes by your own columns.
   attr_accessor :id, :title, :release_year, :artist_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# album = .new
# artist.title = 'Doolittle'
# artist.release_year = '1989'

```
You may choose to  test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.
```ruby
# EXAMPLE
# Table name: albums

# Repository class
# (in lib/album_repository.rb)

class AlbumRepository

  # Selecting all albums
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of albums objects.
  end

  # Gets a single album by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;
    # The placeholder $1 is a "parameter" of the SQL query.
    # It needs to be matched to the corresponding element 
    # of the array given in second argument to exec_params.
    # (If we needed more parameters, we would call them $2, $3...
    # and would need the same number of values in the params array).

    # Returns a single Album object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(album)
  # end

  # Updates the album with new values
  # one arguments: an Album object
  def update(album)
    # Executes the SQL query:
    # UPDATE albums SET title = $1 release_year = $2 artist_id = $3 WHERE id = $4;

    # Does not return anything.
  end
  
   # creates a new album
   # one argument : an Album object
  def create (album)
    # Executes the SQL query:
    # INSERT INTO albums (id, title, release_year, artist_id) VALUES($1, $2, $3, $4);

    # Does not return anything.
  end
end
```
6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all albums
```ruby
repo = AlbumRepository.new

album = repo.all

album.length # =>  3

album[0].id # =>  1
album[0].title # =>  'Doolittle'
album[0].release_year # =>  '1989'
album[0].artist_id # => '1'

artists[1].id # =>  2
album[1].title # =>  'Super Trouper'
album[1].release_year # =>  '1980'
album[1].artist_id # => '2'

artists[1].id # =>  3
album[1].title # =>  'Surfer Rosa'
album[1].release_year # =>  '1988'
album[1].artist_id # => '1'
```

# 2
# Get a single album
```ruby
repo = AlbumRepository.new

album = repo.find(2) #Performs a SELECT query and returns a single Album object.

album.id # =>  2
album.title # =>  'Super Trouper'
album.release_year # =>  '1980'
album.artist_id # => '2'

album = repo.find(3)

album.id # =>  3
album.title # =>  'Surfer Rosa'
album.release_year # =>  '1988'
album.artist_id # => '1'
```

# 3
# Update a specific album
```ruby
repo = AlbumRepository.new

album = repo.update(3, 1987)

album.id # =>  3
album.title # =>  'Surfer Rosa'
album.release_year # =>  '1987'
album.artist_id # => '1'

# 3
# Creates a new album

repo = AlbumRepository.new

album = Album.new

album.id = '4'
album.title = 'Trompe le Monde '
album.release_year = '1991'
album.artist_id = '1'

repo.create(album) #=> nil
repo.all
last_album = repo.all.last

last_album.id # =>'4'
last_album.title # => 'Trompe le Monde '
last_album.release_year # => '1991'
last_album.artist_id # => '1'

```

# Add more examples for each method
Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/album_repository_spec.rb
```ruby
def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  # (your tests will go here).
end
```
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

