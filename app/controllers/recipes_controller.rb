class RecipesController < ApplicationController
  def index
    #@recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
    @recipes = Recipe.reorder("total_likes DESC").paginate(page: params[:page], per_page: 2) #.reoder("total_likes DESC")
  end
  def show
    @recipe = Recipe.find(params[:id])
  end
  def new
    @recipe = Recipe.new
  end

  def create
    #binding.pry
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.find(2)

    if @recipe.save
      flash[:success] = "Your recipe was created successfully"
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end
  def update
    @recipe= Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was update successfully"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
  def like
    @recipe = Recipe.find(params[:id])
    #пока прописано строго т к не аутентификации , параметр like передаем отдельно
    like= Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your trumb is counted"
      #возврат к первичной странице, откуда был вызов
      redirect_to :back
    else
      flash[:danger] = "Only one time"
      #возврат к первичной странице, откуда был вызов
      redirect_to :back
    end

  end

  private
    def recipe_params
      params.require(:recipe).permit(:name,:summary,:description,:picture)
    end
end