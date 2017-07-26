class Recipe < ActiveRecord::Base
	has_many :recipe_ingredients
	has_many :ingredients, through: :recipe_ingredients

	validates :name, presence: true

	def ingredient_names
		self.ingredients.collect{|ingredient| ingredient.name}
	end

	def ingredients_and_amounts
		self.recipe_ingredients.collect do |recipe_ingredient|
			[recipe_ingredient.recipe, recipe_ingredient.amount]
		end
	end

	def can_make?(times=1)
		ingredients_and_amounts.all? do |ingred_amount|
			ingred_amount[0].enough?(ingred_amount[1]*times)
		end
	end

	def can_make_times
		prepare_times = 0 
		while can_make?(prepare_times+1)
			prepare_times += 1
		end
		prepare_times
	end
end
