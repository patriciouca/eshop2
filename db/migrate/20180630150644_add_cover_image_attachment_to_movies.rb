class AddCoverImageAttachmentToMovies < ActiveRecord::Migration
  def up
    add_attachment :movies, :cover_image
  end

  def down
    remove_attachment :movies, :cover_image
  end
end
