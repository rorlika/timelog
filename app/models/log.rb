class Log < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :hours, :numericality => {:only_integer => true}
  validates_presence_of :project_id, :hours, :log_date
end
