require_relative 'view'

class Controller
  def initialize(cookbook) # INSTANCE
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # get all recipes
    display_recipes
  end

  def create
    # ask user for name
    name = @view.ask_for_name
    # ask user for description
    description = @view.ask_for_description
    # create an instance of a recipe
    recipe = Recipe.new(name, description)
    # tell the cookbook to add it
    @cookbook.add_recipe(recipe)
  end

  def destroy
    display_recipes
    # tell user to give us a recipe #
    index = @view.ask_for_index
    @cookbook.remove_recipe(index)
  end

  private

  def display_recipes
    recipes = @cookbook.all
    @view.display_recipes(recipes)
  end

end
