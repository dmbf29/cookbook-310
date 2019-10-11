require 'nokogiri'
require 'open-uri'

class ScrapingService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # need nokogiri / open-uri
    # build the url with the KEYWORD
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{@keyword}"
    # tell open-uri to open the url (and read)
    html = open(url).read
    # tell Nokogiri to build objects with the HTML
    nokogiri_objects = Nokogiri::HTML(html)
    # search through the doc for what we want
    nokogiri_objects.search('.m_contenu_resultat').take(5).map do |recipe_card|
      recipe_hash = {}
      recipe_hash[:name] = recipe_card.search('.m_titre_resultat').text.strip
      details = recipe_card.search('.m_detail_recette').text.strip.split(' - ')
      recipe_hash[:description] = details[1]
      recipe_hash[:difficulty] = details[2]
      recipe_hash[:prep_time] = recipe_card.search('.m_prep_time').first.parent.text.strip
      Recipe.new(recipe_hash)
      # - name, description, difficulty, prep_time
      # create a new instance - >Recipe.new
    end
  end
end
