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

merchant1 = Merchant.new({ "name" => "Tesco" })
merchant2 = Merchant.new({ "name" => "Amazon" })
merchant3 = Merchant.new({ "name" => "ScotRail" })

merchant1.save()
merchant2.save()
merchant3.save()

binding.pry
nil