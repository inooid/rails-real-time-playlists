class Playlist < ActiveRecord::Base
  sync :all
  before_save :falsify_all_others
  after_create :falsify_all_others

  def falsify_all_others
    # REFACTORING NEEDED
    Playlist.where('id != ?', id).update_all("active = 'false'") if active == true
  end
end
