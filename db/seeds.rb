require('pry')
require_relative('../models/tag')
require_relative('../models/merchant')

Tag.delete_all()

tag1 = Tag.new({ "name" => "Groceries" })
tag2 = Tag.new({ "name" => "Entertainment" })
tag3 = Tag.new({ "name" => "Transport" })

tag1.save()
tag2.save()
tag3.save()

binding.pry
nil