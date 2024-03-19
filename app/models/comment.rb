class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user
  validates :commenter, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: {minimum: 5}
end
