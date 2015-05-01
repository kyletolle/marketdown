class User < ActiveRecord::Base
  include Surrounded

  has_many :books
end

