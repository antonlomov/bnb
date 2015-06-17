class AddAttachmentPictureToAppartments < ActiveRecord::Migration
  def self.up
    change_table :appartments do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :appartments, :picture
  end
end
