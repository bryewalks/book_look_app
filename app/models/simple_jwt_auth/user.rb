require File.expand_path('../../app/models/simple_jwt_auth/user', SimpleJwtAuth::Engine.called_from)

module SimpleJwtAuth
  class User
    has_many :books
  end
end