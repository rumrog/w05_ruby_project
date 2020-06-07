require_relative('../db/sql_runner')

class Merchant

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO merchants
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING *"
    values = [@name]
    merchant = SqlRunner.run(sql, values).first
    @id = merchant['id'].to_i
  end

  def update()
    sql = "UPDATE merchants
    SET
    (
      name
    ) =
    (
      $1
    )
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    merchant_data = SqlRunner.run(sql)
    return Merchant.map_items(merchant_data)
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  def self.map_items(merchant_data)
    result = merchant_data.map { |merchant| Merchant.new(merchant) }
    return result
  end

end