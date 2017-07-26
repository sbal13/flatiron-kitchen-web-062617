class RecipesController < ApplicationController

	def index
		@recipes = Recipe.all
	end

	def show
		set_recipe
		@ingredients = @recipe.ingredients
	end

	def new
		@recipe = Recipe.new
		@ingredients = Ingredient.all
	end

	def create

		@recipe = Recipe.new(recipe_params)
		ingredients = []

		params[:recipe][:ingredient_ids].each do |id|
			ingredients << Ingredient.find(id) if !id.empty?
		end

		@recipe.ingredients = ingredients


		if @recipe.valid?
			@recipe.save
			redirect_to @recipe
		else
			render :new
		end
	end

	def edit
		set_recipe
		@ingredients = Ingredient.all
	end

	def update
		temp_recipe = Recipe.new(recipe_params)
		ingredients = []

		params[:recipe][:ingredient_ids].each do |id|
			ingredients << Ingredient.find(id) if !id.empty?
		end

		if temp_recipe.valid?
			set_recipe
			@recipe.update(recipe_params)
			@recipe.ingredients = ingredients
			@recipe.save
			redirect_to @recipe
		else
			render :edit
		end
	end

	def destroy
		set_recipe
		@recipe.destroy
		redirect_to recipes_path
	end

	private

	def set_recipe
		@recipe = Recipe.find(params[:id])
	end

	def recipe_params
		params.require(:recipe).permit(:name, :description, :ingredient_ids)
	end
end