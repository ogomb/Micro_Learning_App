require 'sequel'
require 'bcrypt'

class User < Sequel::Model
  set_primary_key :id

  def hash_password(password)
    BCrypt::Password.create(password).to_s
  end

  def test_password(password, hash)
    BCrypt::Password.new(hash) == password
  end
end
