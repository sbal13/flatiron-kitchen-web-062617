class Ingredient < ActiveRecord::Base
	has_many :recipe_ingredients
	has_many :recipes, through: :recipe_ingredients

	validates :name, presence: true
	validates :stock, numericality: {greater_than: 0}, if: :stock

	def use(amount)
		self.stock -= amount
	end

	def restock(amount)
		self.stock += amount
	end

	def enough?(amount)
		(self.stock - amount) > 0
	end
end
