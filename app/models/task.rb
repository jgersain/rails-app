# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'

  # validations
  validates :name, :description, presence: true
  validates :name, uniqueness: { case_insensitive: false }
  
  # custom validation
  validate :due_date_validity

  def due_date_validity
    # date must be present, y conditions are false, exec error
    return if due_date.blank?
    return if due_date > Date.today
    errors.add :due_date, I18n.t('task.errors.invalid_due_date')
  end
end
