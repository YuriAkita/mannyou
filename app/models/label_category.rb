class LabelCategory < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings
end
