class CocktailsController < ApplicationController
  before_action :find_cocktail, only: [:show, :destroy]
  
  def index
    @cocktails = Cocktail.all
  end

  def new
    @cocktail = Cocktail.new
  end

  def show
  end

  def create
    @cocktail = Cocktail.new(set_params)
    @cocktail.save
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end    
  end

  private

  def set_params
    params.require(:cocktail).permit(:name)
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end
