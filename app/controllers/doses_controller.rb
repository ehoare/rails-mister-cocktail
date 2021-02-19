class DosesController < ApplicationController
  before_action :find_dose, only: []

  def index
    @doses = Dose.all
  end

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end
  
  def create
    @dose = Dose.new(set_params)
    # we need `ingredient_id` and cocktail_id to associate review with corresponding restaurant
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredient = Ingredient.find(params[:dose][:ingredient_id])
    @dose.cocktail = @cocktail
    @dose.ingredient = @ingredient
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end
  

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.find(@cocktail)
    @dose.destroy

    redirect_to doses_path
  end

  private

  def set_params
    params.require(:dose).permit(:description, :ingredient_id, :cocktail_id )
  end
end
