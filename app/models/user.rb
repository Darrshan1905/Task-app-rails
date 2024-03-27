class User < ApplicationRecord
    has_secure_password
    has_many :projects, dependent: :destroy
    has_many :tasks
    has_many :comments
    enum role: [:user, :admin]
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :password, presence: true, on: :create
    validates_length_of :password, minimum: 6, if: :password_required

    private

    def password_required
        new_record? || password.present? || password_confirmation.present?
    end
end


