class View
  def display_recipes(recipes) # an array
    if recipes.any?
      recipes.each_with_index do |recipe, index|
        puts "#{index + 1}.) #{recipe.name} - #{recipe.description}"
      end
    else
      puts "No recipes. Add one!"
    end
  end

  def ask_for_name
    puts "What's the name of the recipe?"
    gets.chomp
  end

  def ask_for_description
    puts "What's the description of the recipe?"
    gets.chomp
  end

  def ask_for_index
    puts "Which number to delete?"
    gets.chomp.to_i - 1
  end
end
