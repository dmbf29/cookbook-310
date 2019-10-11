require_relative 'cookbook'    # You need to create this file!
require_relative 'controller'  # You need to create this file!
require_relative 'router'

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook = Cookbook.new(csv_file) #instance
controller = Controller.new(cookbook)
router = Router.new(controller)
router.run

