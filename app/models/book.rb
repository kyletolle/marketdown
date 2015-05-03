class Book < ActiveRecord::Base
  include Surrounded

  belongs_to :author, class_name: 'User'

  validates :author, presence: true

  has_many :purchases
end

