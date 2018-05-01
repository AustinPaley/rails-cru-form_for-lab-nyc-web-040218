class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
    @artist = @song.artist
    @genre = @song.genre
  end

  def new
    @song = Song.new
  end

  def create
    @genre = Genre.find_or_create_by(name: params[:song][:genre_id])
    @artist = Artist.find_or_create_by(name: params[:song][:artist_id])
    @song = Song.create(name: params[:song][:name], artist_id: @artist.id, genre_id: @genre.id)
    # @song = Song.create(params.require(:song).permit(:name, @artist.id, @genre.id)) ##This is for security. I don't know how to use it.
    redirect_to song_path(@song)
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    @song.update(params.require(:song).permit(:name, :artist_id, :genre_id))
    redirect_to song_path(@song)
  end
end
