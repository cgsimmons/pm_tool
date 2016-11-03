class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, uniqueness: true
  validate :is_valid_due_date?

  def unfinishedTasks
    tasks.where("done = false")
  end

  def finishedTasks
    tasks.where("done = true")
  end

  private
  def is_valid_due_date?
    if self.due_date < Date.today
      errors.add(:due_date, 'cannot be before today\'s date.')
      return false
    end
    return true
  end
end
