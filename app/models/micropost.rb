class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.content_max }
  validate :picture_size

  mount_uploader :picture, PictureUploader

  scope :newest_first, ->{order created_at: :desc}

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, t("micropost.err"))
    end
  end
end
