require_relative 'view'
require_relative 'scraping_service'

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
    # name =
    # # ask user for description
    # description =
    # create an instance of a recipe
    recipe = Recipe.new(
        name: @view.ask_for_('name'),
        description: @view.ask_for_('description'),
        prep_time: @view.ask_for_('prep time')
      )
    # tell the cookbook to add it
    @cookbook.add_recipe(recipe)
  end

  def destroy
    display_recipes
    # tell user to give us a recipe #
    index = @view.ask_for_index
    @cookbook.remove_recipe(index)
  end

  def import
    # ask user(view) what they want to search for -> keyword
    keyword = @view.ask_for_('keyword')
    # add the keyword in the path of the url
    recipes = ScrapingService.new(keyword).call
    # p recipes
    # return a collection of recipes # array
    # tell the view to display the recipes
    @view.display_recipes(recipes)
    # ask user(view) which recipe they want to save -> index
    index = @view.ask_for_('number').to_i - 1
    recipe = recipes[index]
    # give the recipe to the cookbook
    @cookbook.add_recipe(recipe)
    display_recipes
  end

  def mark
    display_recipes
    index = @view.ask_for_('recipe to mark').to_i - 1
    @cookbook.mark_as_done(index)
  end

  private

  def display_recipes
    recipes = @cookbook.all
    @view.display_recipes(recipes)
  end
end
