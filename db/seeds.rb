require('pry')
require_relative('../models/tag')
require_relative('../models/merchant')
require_relative('../models/transaction')

Tag.delete_all()
Merchant.delete_all()
Transaction.delete_all()

tag1 = Tag.new({ 'name' => 'Groceries' })
tag2 = Tag.new({ 'name' => 'Entertainment' })
tag3 = Tag.new({ 'name' => 'Transport' })

tag1.save()
tag2.save()
tag3.save()

merchant1 = Merchant.new({ 'name' => 'Tesco' })
merchant2 = Merchant.new({ 'name' => 'Amazon' })
merchant3 = Merchant.new({ 'name' => 'ScotRail' })

merchant1.save()
merchant2.save()
merchant3.save()

transaction1 = Transaction.new({ 
  'tag_id' => tag1.id,
  'merchant_id' => merchant1.id,
  'date' => '2020-06-06',
  'amount' => 20.00
})

transaction2 = Transaction.new({
  'tag_id' => tag2.id,
  'merchant_id' => merchant2.id,
  'date' => '2020-06-07',
  'amount' => 30.00
})

transaction3 = Transaction.new({
  'tag_id' => tag3.id,
  'merchant_id' => merchant3.id,
  'date' => '2020-06-08',
  'amount' => 50.00
})

transaction1.save()
transaction2.save()
transaction3.save()

binding.pry
nil