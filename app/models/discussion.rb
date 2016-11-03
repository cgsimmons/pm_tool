class Discussion < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: {scope: :project_id}
end
