class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :scores, dependent: :destroy
end
