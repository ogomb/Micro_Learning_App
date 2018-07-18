require_relative '../app/models/category'
require_relative '../spec/support/db'


module MicroLearning
  RSpec.describe 'Category Model' do
    let(:category_model) {
      Category.new('name' => 'test_user')
    }
    describe 'category' do
      context 'with a valid entry' do
        it 'should successfully save the record' do
          result = category_model.save!

          expect(result).to eq(true)
        end
      end

      context 'with a invalid entry' do
        it 'should reject empty entry' do
          category_model.name = ""
          result = category_model.valid?

          expect(result).to eq(false)
        end
      end
    end
  end
end