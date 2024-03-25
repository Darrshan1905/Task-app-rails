class Task < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :project
  belongs_to :user
  validates :name, presence: true
  validates :duration, presence: true
  validates :name, uniqueness: { scope: :project_id, message: "should be unique within the project" }
end
