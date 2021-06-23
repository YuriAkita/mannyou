class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  has_many :tasks, dependent: :destroy
  before_destroy :check_admin_user_exist
  before_update :check_admin_update_exist

  def check_admin_user_exist
    if User.where(admin: true).count <= 1 && self.admin == true
      throw(:abort)
    end
  end

  def check_admin_update_exist
    if User.where(admin: true).count == 1 && self.admin == false
      throw(:abort)
    end
  end

end
