class Book < ApplicationRecord
  # serialize :author
  belongs_to :user
end
