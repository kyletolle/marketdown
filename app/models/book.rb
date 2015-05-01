class Book < ActiveRecord::Base
  include Surrounded

  belongs_to :user

  validates :user, presence: true
end

