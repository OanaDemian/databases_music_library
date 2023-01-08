require_relative 'lib/album_repository'
require_relative 'lib/database_connection'
require_relative 'lib/album'

# We need to give the database name to the method `connect`.
# DatabaseConnection.connect('music_library_test')

# file: app.rb

require_relative './lib/album_repository'
require_relative './lib/artist_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect('music_library_test')
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
    welcome
    choice = @io.gets.chomp
    handle_choice(choice)
  end

  def welcome
    @io.puts "Welcome to the music library manager!"
    @io.puts
    @io.puts "What would you like to do?"
    @io.puts " 1 - List all album"
    @io.puts " 2 - List all artists"
    @io.puts
    @io.puts "Enter your choice: "
  end

  def handle_choice(choice)
    @io.puts
    case choice 
    when '1'
      list_of_albums
    when '2'
      list_of_artists
    else
      @io.puts "That is not a valid choice."
    end
  end
  def list_of_albums
    @album_repository = AlbumRepository.new
    albums = @album_repository.all
    albums.sort_by!{|album| album.id.to_i}
    albums.each do |record| 
      @io.puts "#{record.id} - #{record.title} - #{record.release_year} - #{record.artist_id}"
    end
  end

  def list_of_artists
    @artist_repository = ArtistRepository.new
    artists = @artist_repository.all
    artists.sort_by!{|artist| artist.id.to_i}
    artists.each do |record| 
      @io.puts "#{record.id} - #{record.name} - #{record.genre}"
    end
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library_test',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
