require SimpleJwtAuth::Engine.root.join('app', 'models', 'user')
module SimpleJwtAuth
  class User
    def speak
      puts "hello"
    end
  end
end