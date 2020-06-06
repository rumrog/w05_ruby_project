require('pry')
require_relative('../models/tag')

Tag.delete_all()

tag1 = Tag.new({ "tag_name" => "Groceries" })
tag2 = Tag.new({ "tag_name" => "Entertainment" })
tag3 = Tag.new({ "tag_name" => "Transport" })

tag1.save()
tag2.save()
tag3.save()

binding.pry
nil