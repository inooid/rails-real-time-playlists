json.array!(@playlists) do |playlist|
  json.extract! playlist, :id, :name, :url, :active
  json.url playlist_url(playlist, format: :json)
end
