class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [
    :show, :edit, :update, :destroy, :change_active_state
  ]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.order(:created_at)
  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
  end

  # GET /playlists/1/edit
  def edit
  end

  def change_active_state
    if @playlist.update(playlist_active_params)
      sync_update @playlist
      redirect_to playlists_path, notice: 'Playlist was successfully updated.'
    else
      redirect_to playlists_path
    end
  end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.new(playlist_params)

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to playlists_path, notice: 'Playlist was successfully created.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        sync_update @playlist
        format.html { redirect_to playlists_path, notice: 'Playlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  # Never trust parameters from the scary internet, only
  # allow the white list through.
  def playlist_params
    params.require(:playlist).permit(:name, :url, :active)
  end

  def playlist_active_params
    params.permit(:active)
  end
end
