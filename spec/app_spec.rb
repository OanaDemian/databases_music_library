require_relative '../app.rb'
require_relative '../lib/album_repository'
require_relative '../lib/artist_repository'
require_relative 'reseed_music_library_db'
RSpec.describe 'App' do
  before(:each) do 
    reseed_tables
  end

  def displays_welcome_message(io)
    expect(io).to receive(:puts).with("Welcome to the music library manager!")
    expect(io).to receive(:puts).with(no_args)
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with(" 1 - List all album")
    expect(io).to receive(:puts).with(" 2 - List all artists")
    expect(io).to receive(:puts).with(no_args)
    expect(io).to receive(:puts).with("Enter your choice: ")
  end

  def displays_all_albums(io)
    expect(io).to receive(:puts).with("1 - Doolittle - 1989 - 1")
    expect(io).to receive(:puts).with("2 - Surfer Rosa - 1988 - 1")
    expect(io).to receive(:puts).with("3 - Waterloo - 1974 - 2")
    expect(io).to receive(:puts).with("4 - Super Trouper - 1980 - 2")
    expect(io).to receive(:puts).with("5 - Bossanova - 1990 - 1")
    expect(io).to receive(:puts).with("6 - Lover - 2019 - 3")
    expect(io).to receive(:puts).with("7 - Folklore - 2020 - 3")
    expect(io).to receive(:puts).with("8 - I Put a Spell on You - 1965 - 4")
    expect(io).to receive(:puts).with("9 - Baltimore - 1978 - 4")
    expect(io).to receive(:puts).with("10 - Here Comes the Sun - 1971 - 4")
    expect(io).to receive(:puts).with("11 - Fodder on My Wings - 1982 - 4")
    expect(io).to receive(:puts).with("12 - Ring Ring - 1973 - 2")
  end

  def displays_all_artists(io)
    expect(io).to receive(:puts).with("1 - Pixies - Rock")
    expect(io).to receive(:puts).with("2 - ABBA - Pop")
    expect(io).to receive(:puts).with("3 - Taylor Swift - Pop")
    expect(io).to receive(:puts).with("4 - Nina Simone - Pop")
  end

  it "Lists all albums when users chooses 1" do
    io = double :io
    displays_welcome_message(io)
    expect(io).to receive(:gets).and_return("1")
    displays_all_albums(io)
    expect(io).to receive(:puts).with(no_args)
    app = Application.new('music_library_test', io, AlbumRepository.new, ArtistRepository.new)
    app.run
  end

  it "Lists all artists when users chooses 2" do
    io = double :io
    displays_welcome_message(io)
    expect(io).to receive(:gets).and_return("2")
    displays_all_artists(io)
    expect(io).to receive(:puts).with(no_args)
    app = Application.new('music_library_test', io, AlbumRepository.new, ArtistRepository.new)
    app.run
  end

  it "displays an error message if user makes wrong choice" do
    io = double :io
    displays_welcome_message(io)
    expect(io).to receive(:gets).and_return("3")
    expect(io).to receive(:puts).with("That is not a valid choice.")
    expect(io).to receive(:puts).with(no_args)
    app = Application.new('music_library_test', io, AlbumRepository.new, ArtistRepository.new)
    app.run
  end
end
