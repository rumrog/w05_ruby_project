require_relative('../db/sql_runner')

class Transaction

  attr_reader :id
  attr_accessor :tag_id, :merchant_id, :amount
  
  def initialize(options)
    @id = options['id'].to_i
    @tag_id = options['tag_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @amount = options['amount'].to_f
  end

  def save()
    sql = 'INSERT INTO transactions
    (
      tag_id, 
      merchant_id, 
      amount
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING *'
    values = [@tag_id, @merchant_id, @amount]
    transaction = SqlRunner.run(sql, values).first
    @id = transaction['id'].to_i
  end

  def self.all()
    sql = 'SELECT * FROM transactions'
    transaction_data = SqlRunner.run(sql)
    return Transaction.map_items(transaction_data)
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def self.map_items(transaction_data)
    result = transaction_data.map { |transaction| Transaction.new(transaction) }
    return result
  end

  def tag()
    sql = 'SELECT * FROM tags
    WHERE id = $1'
    values = [@tag_id]
    results = SqlRunner.run(sql, values)
    return Tag.new(results.first)
  end

  def merchant()
    sql = 'SELECT * FROM merchants
    WHERE id = $1'
    values = [@merchant_id]
    results = SqlRunner.run(sql, values)
    return Merchant.new(results.first)
  end

  def self.total()
    sql = 'SELECT SUM(amount)
    FROM transactions'
    total = SqlRunner.run(sql).first
    return total["sum"].to_f
  end

end