require_relative('../db/sql_runner')

class Tag

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = 'INSERT INTO tags
    (name) VALUES ($1) RETURNING *'
    values = [@name]
    tag = SqlRunner.run(sql, values).first
    @id = tag['id'].to_i
  end

  def update()
    sql = 'UPDATE tags
    SET name = $1
    WHERE id = $2'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = 'SELECT * FROM tags'
    tag_data = SqlRunner.run(sql)
    return Tag.map_items(tag_data)
  end

  def self.delete_all()
    sql = 'DELETE FROM tags'
    SqlRunner.run(sql)
  end

  def self.map_items(tag_data)
    result = tag_data.map { |tag| Tag.new(tag) }
    return result
  end

  def self.find(id)
    sql = 'SELECT * FROM tags
    WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Tag.new(result.first)
  end

end