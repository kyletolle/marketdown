class Purchase < ActiveRecord::Base
  include Surrounded

  belongs_to :purchaser, class_name: 'User'
  belongs_to :book
end

