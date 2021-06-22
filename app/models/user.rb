class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  has_many :tasks, dependent: :destroy
  before_destroy :check_admin_user_exist

  def check_admin_user_exist
    if User.where(admin: true).count < 2
    else
      throw(:abort)
      errors.add :base, '少なくとも1つ、管理者用の認証が必要です'
    end
  end


end
