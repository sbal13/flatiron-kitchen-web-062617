class IngredientsController < ApplicationController

	def index
		@ingredients = Ingredient.all
	end

	def show
		set_ingredient
	end

	def new
		@ingredient = Ingredient.new
	end

	def create
		@ingredient = Ingredient.new(ingredient_params)
		if @ingredient.valid?
			@ingredient.save
			redirect_to @ingredient
		else
			render :new
		end
	end

	def edit
		set_ingredient
	end

	def update
		temp_ingredient = Ingredient.new(ingredient_params)
		if temp_ingredient.valid?
			set_ingredient
			@ingredient.update(ingredient_params)
			redirect_to @ingredient
		else
			render :edit
		end
	end

	def destroy
		set_ingredient
		@ingredient.destroy
		redirect_to ingredients_path
	end

	def restock
		set_ingredient
		@ingredient.restock(ingredient_params)
		@ingredient.save
		redirect_to @ingredient
	end

	private

	def set_ingredient
		@ingredient = Ingredient.find(params[:id])
	end

	def ingredient_params
		params.require(:ingredient).permit(:name, :stock, :description)
	end
end