require_relative('../db/sql_runner')

class Budget

  attr_reader :id
  attr_accessor :amount

  def initialize(options)
    @id = options['id'].to_i
    @amount = options['amount'].to_f
  end

  def save()
    sql = 'INSERT INTO budgets
    (
      amount
    )
    VALUES
    (
      $1
    )
    RETURNING *'
    values = [@amount]
    budget = SqlRunner.run(sql, values).first
    @id = budget['id'].to_i
  end

  def update()
    sql = 'UPDATE budgets
    SET amount = $1
    WHERE id = $2'
    values = [@amount, @id]
    SqlRunner.run(sql, values)
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

  def self.find(id)
    sql = 'SELECT * FROM budgets
    WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Budget.new(result.first)
  end

end