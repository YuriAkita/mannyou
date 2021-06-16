class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  scope :title_search, -> (title) { where("title LIKE ?", "%#{title}%") }
  scope :status_search, -> (status) { where(status: status) }
  enum priority: { 高: 0, 中: 1, 低: 2 }
end
