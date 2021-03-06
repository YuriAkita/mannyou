class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }
  scope :title_search, -> (title) { where("title LIKE ?", "%#{title}%") }
  scope :status_search, -> (status) { where(status: status) }
  scope :priority_search, -> (priority) { where(priority: priority) }
  scope :label_category_search, -> (id) { joins(:labelings).where("labelings.label_category_id = ?", id) }
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :label_categories, through: :labelings
end
