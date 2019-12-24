class Book < ApplicationRecord
  serialize :author
  belongs_to :user, :class_name => 'SimpleJwtAuth::User'
end
