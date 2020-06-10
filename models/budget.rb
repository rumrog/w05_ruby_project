require_relative('../db/sql_runner')

class Budget

  attr_reader :id
  attr_accessor :tag_id, :amount

  def initialize(options)
    @id = options['id'].to_i
    @tag_id = options['tag_id'].to_i
    @amount = options['amount'].to_f
  end

  def save()
    sql = 'INSERT INTO budgets
    (
      tag_id,
      amount
    )
    VALUES
    (
      $1, $2
    )
    RETURNING *'
    values = [@tag_id, @amount]
    budget = SqlRunner.run(sql, values).first
    @id = budget['id'].to_i
  end

end