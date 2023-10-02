class Relationship < ApplicationRecord
  has_many :end_users, dependent: :destroy
end
