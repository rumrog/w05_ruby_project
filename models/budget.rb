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

  def self.all()
    sql = 'SELECT * FROM budgets'
    budget_data = SqlRunner.run(sql)
    return Budget.map_items(budget_data)
  end

  def self.delete_all()
    sql = 'DELETE FROM budgets'
    SqlRunner.run(sql)
  end

  def self.map_items(budget_data)
    result = budget_data.map { |budget| Budget.new(budget) }
    return result
  end

end