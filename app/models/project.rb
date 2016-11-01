class Project < ApplicationRecord
  has_many :tasks
  validates :title, presence: true, uniqueness: true
  validate :is_valid_due_date?

  private
  def is_valid_due_date?
    if self.due_date < Date.today
      errors.add(:due_date, 'cannot be before today\'s date.')
      return false
    end
    return true
  end
end
