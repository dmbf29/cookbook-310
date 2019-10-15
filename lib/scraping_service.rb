require_relative 'recipe'
require 'open-uri'
require 'nokogiri'

# ScrapingService.new(keyword).call => an array of instances
class ScrapingService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # return an array of recipes
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{@keyword}"
    # open the url and get the html
    html = open(url).read
    # tell nokogiri to turn html into objects
    nokogiri_objects = Nokogiri::HTML(html)
    # get the names and description from each one
    nokogiri_objects.search('.m_contenu_resultat').first(5).map do |recipe_card|
      name = recipe_card.search('.m_titre_resultat').text.strip
      details = recipe_card.search('.m_detail_recette').text.strip.split(' - ')
      description = details[1]
      # difficulty = details[2]
      prep_time = recipe_card.search('.m_prep_time').first.parent.text.strip
      Recipe.new(
        name: name,
        description: description,
        prep_time: prep_time
      )
    end
  end
end
