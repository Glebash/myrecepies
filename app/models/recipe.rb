class Recipe < ActiveRecord::Base
  belongs_to :chef
  has_many :likes
  #должен быть chef_id
  validates :chef_id, presence: true
  validates :name, presence: true, length: {minimum: 5, maximum: 100}
  validates :summary, presence: true, length: { minimum: 10, maximum: 150}
  validates :description, presence: true, length: {minimum: 20, maximum: 500}
  mount_uploader :picture, PictureUploader
  validate :picture_size

  before_save :default_vote_count

  def thumbs_up_total
    #self.likes.where(like: true).size
    self.total_likes
  end
  def thumbs_down_total
    self.total_dislikes
   # self.likes.where(like: false).size
  end
  def default_vote_count
    self.total_likes ||=0
    self.total_dislikes ||=0
  end
  private
    def picture_size
      if(picture.size> 5.megabytes)
        errors.add(:picture, "should be less 5MB")
      end
    end
end