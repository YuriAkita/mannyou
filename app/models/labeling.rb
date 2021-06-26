class Labeling < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :label_category, optional: true
end
