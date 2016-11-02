class Discussion < ApplicationRecord
  belongs_to :project
  
  validates :title, presence: true, uniqueness: {scope: :project_id}
end
