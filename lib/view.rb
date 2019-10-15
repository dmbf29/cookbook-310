class View
  def display_recipes(recipes) # an array
    if recipes.any?
      recipes.each_with_index do |recipe, index|
        x_mark = recipe.done? ? "X" : " "
        puts "#{index + 1}.) [#{x_mark}] - #{recipe.name} - #{recipe.description} | #{recipe.prep_time}"
      end
    else
      puts "No recipes. Add one!"
    end
  end
  # def ask_for_name
  #   puts "What's the name of the recipe?"
  #   gets.chomp
  # end

  # def ask_for_description
  #   puts "What's the description of the recipe?"
  #   gets.chomp
  # end

  def ask_for_(thing)
    puts "What's the #{thing}?"
    gets.chomp
  end

  def ask_for_index
    puts "Which number to delete?"
    gets.chomp.to_i - 1
  end
end
