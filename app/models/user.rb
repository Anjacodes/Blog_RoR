class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :posts
  has_many :comments
  has_many :likes, foreign_key: :user_id, dependent: :destroy

  validates :name, presence: true
  validates :postsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true

  def last_three
    posts.order(created_at: :desc).limit(3)
  end
  
  def set_default_role
    self.role ||= :user
  end
end
