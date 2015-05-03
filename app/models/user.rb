class User < ActiveRecord::Base
  include Surrounded

  has_many :books

  has_many :purchases, foreign_key: :purchaser_id
end

