require_relative '../app/models/category'

categories = [
    {name: 'Business'},
    {name: 'entertainment'},
    {name: 'general'},
    {name: 'health'},
    {name: 'science'},
    {name: 'sports'},
    {name: 'technology'},
]

categories.each do |category|
  Category.create(category)
end