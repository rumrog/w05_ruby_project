require_relative('../db/sql_runner')

class Transaction

  attr_reader :id
  attr_accessor :tag_id, :merchant_id, :date, :amount
  
  def initialize(options)
    @id = options['id'].to_i
    @tag_id = options['tag_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @date = options['date']
    @amount = options['amount'].to_f
  end

  def save()
    sql = 'INSERT INTO transactions
    (
      tag_id, 
      merchant_id,
      date, 
      amount
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING *'
    values = [@tag_id, @merchant_id, @date, @amount]
    transaction = SqlRunner.run(sql, values).first
    @id = transaction['id'].to_i
  end

  def update()
    sql = 'UPDATE transactions
    SET amount = $1
    WHERE id = $2'
    values = [@amount, @id]
    SqlRunner.run(sql, values)
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

  def self.find(id)
    sql = 'SELECT * FROM transactions
    WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Transaction.new(result.first)
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

  def self.sort_by_date()
    sql = 'SELECT * FROM transactions
    ORDER BY date'
    sorted = SqlRunner.run(sql)
    return Transaction.map_items(sorted)
  end

  def self.filter_by_merchant(merchant_id)
    sql = 'SELECT * FROM transactions 
    WHERE merchant_id = $1'
    values = [merchant_id]
    results = SqlRunner.run(sql, values)
    return Transaction.map_items(results)
  end

  def self.merchants_total(merchant_id)
    sql = 'SELECT SUM(amount)
    FROM transactions
    WHERE merchant_id = $1'
    values = [merchant_id]
    total = SqlRunner.run(sql, values).first
    return total['sum'].to_f
  end

  def self.filter_by_tag(tag_id)
    sql = 'SELECT * FROM transactions
    WHERE tag_id = $1'
    values = [tag_id]
    results = SqlRunner.run(sql, values)
    return Transaction.map_items(results)
  end

  def self.tags_total(tag_id)
    sql = 'SELECT SUM(amount)
    FROM transactions
    WHERE tag_id = $1'
    values = [tag_id]
    total = SqlRunner.run(sql, values).first
    return total['sum'].to_f
  end

end