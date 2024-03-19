class Project < ApplicationRecord
    belongs_to :user
    has_many :tasks, dependent: :destroy
    validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
    validates :start_date, presence: true
    validates :end_date, presence:true
end
