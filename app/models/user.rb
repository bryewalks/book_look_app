require File.expand_path('../../app/models/user', SimpleJwtAuth::Engine.called_from)

class User
  has_many :books
end
