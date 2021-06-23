class Labeling < ApplicationRecord
  belongs_to :task
  belongs_to :label_category
end
