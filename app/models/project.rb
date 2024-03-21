class Project < ApplicationRecord
    belongs_to :user
    has_many :tasks, dependent: :destroy
    validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
    validates :start_date, presence: true
    validates :end_date, presence:true
    validate :start_date_before_end_date
end

def start_date_before_end_date
    return unless start_date && end_date
    errors.add(:end_date, "must be after start date") if end_date < start_date
end
