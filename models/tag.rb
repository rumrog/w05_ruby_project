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
    ) =
    (
      $1,
    )
    RETURNING *"
    values = [@tag_name]
    tag = SqlRunner.run(sql, values).first
    @id = tag['id'].to_i
  end