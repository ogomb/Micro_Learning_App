require_relative '../app/models/user'
require_relative '../spec/support/db'

module MicroLearning
  RSpec.describe 'User Model' do
    let(:user_model) {
      User.new('email' => 'testuser@gmail.com',
               'name' => 'test_user',
               'password' => '234524524524fdstwrsgfgdfsgd'
      )
    }
    describe 'user' do
      context 'with a valid user' do
        it 'should successfully save the record' do
          result = user_model.save!

          expect(result).to eq(true)
        end
      end

      context 'with a invalid user entry' do
        it 'should reject invalid email' do
          user_model.email = "523423423"
          result = user_model.valid?

          expect(result).to eq(false)
        end

        it 'should reject empty name' do
          user_model.name = ""
          result = user_model.valid?

          expect(result).to eq(false)
        end
      end
    end
  end
end