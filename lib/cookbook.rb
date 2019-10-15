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

  def mark_as_done(index)
    recipe = @recipes[index]
    recipe.mark!
    save_recipes_to_csv
  end

  private

  def load_recipes_from_csv
    CSV.foreach(@csv_file_path) do |row|
      name = row[0]
      description = row[1]
      prep_time = row[2]
      done = row[3] == 'true'
      @recipes << Recipe.new(
         name: name,
         description: description,
         prep_time: prep_time,
         done: done
       )
    end
  end

  def save_recipes_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done?]
      end
    end
  end
end
