class User < ApplicationRecord
    has_secure_password
    has_many :projects, dependent: :destroy
    has_many :tasks
    has_many :comments
    enum role: [:user, :admin]
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :password, presence: true, length: { minimum: 6 }
end
