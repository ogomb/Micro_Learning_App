require 'sequel'
require 'bcrypt'

class User < Sequel::Model
  EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/
  plugin :validation_helpers
  set_primary_key :id

  def hash_password(password)
    BCrypt::Password.create(password).to_s
  end

  def test_password(password, hash)
    BCrypt::Password.new(hash) == password
  end

  def validate
    super
    errors.add(:name, 'User Name cannot be empty') if !name || name.empty? || name.strip.empty?
    errors.add(:email, 'Email in invalid') if !email || email.empty? || !EMAIL.match(email)
  end
end
