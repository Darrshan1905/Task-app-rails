class Task < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :project
  validates :name, presence: true
  validates :duration, presence: true
end
