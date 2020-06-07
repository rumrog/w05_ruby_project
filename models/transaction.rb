require_relative('../db/sql_runner')

class Transaction

  attr_reader :id
  attr_accessor :tag_id, :merchant_id, :amount
  
  def initialize(options)
    @id = options['id'].to_i
    @tag_id = options['tag_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @amount = options['amount'].to_i
  end

  def save()
    sql = "INSERT INTO transactions
    (
      tag_id, merchant_id, amount
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING *"
    values = [@tag_id, @merchant_id, @amount]
    transaction = SqlRunner.run(sql, values).first
    @id = transaction['id'].to_i
  end

end