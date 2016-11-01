class Task < ApplicationRecord
  belongs_to :project
  validates :title, presence: true, uniqueness: { scope: :project_id }
  validates :body, presence: true
  # title should be unique within a project
end
