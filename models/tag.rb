require_relative('../db/sql_runner')

class Tag

  attr_reader :id
  attr_accessor :tag_name

  def initialize(options)
    @id = options['id'].to_i
    @tag_name = options['tag_name']
  end

  def save()
    sql = "INSERT INTO tags
    (
      tag_name
    )
    VALUES
    (
      $1
    )
    RETURNING *"
    values = [@tag_name]
    tag = SqlRunner.run(sql, values).first
    @id = tag['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tags"
    tag_data = SqlRunner.run(sql)
    return Tag.map_items(tag_data)
  end

  def self.map_items(tag_data)
    result = tag_data.map { |tag| Tag.new(tag) }
    return result
  end

end