require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_recipes_from_csv
  end

  def all
    @recipes # an array of INSTANCES
  end

  def add_recipe(recipe) # instance
    @recipes << recipe
    save_recipes_to_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_recipes_to_csv
  end

  def load_recipes_from_csv
    CSV.foreach(@csv_file_path) do |row|
      name = row[0]
      description = row[1]
      @recipes << Recipe.new(name, description)
    end
  end

  def save_recipes_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end
end
