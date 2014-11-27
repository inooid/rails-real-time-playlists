class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :url
      t.boolean :active

      t.timestamps
    end
  end
end
