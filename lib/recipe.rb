class Recipe
  attr_reader :name, :description, :prep_time

  # We have to give a hash to create an instance
  # Recipe.new(description: 'description', name: 'whatve')

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def mark!
    @done = !@done
  end
end
