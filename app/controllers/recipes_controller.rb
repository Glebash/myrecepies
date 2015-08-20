class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :like]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update]
  def index
    #@recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
    @recipes = Recipe.reorder("total_likes DESC").paginate(page: params[:page], per_page: 2)
  end
  def show

  end
  def new
    @recipe = Recipe.new
  end

  def create
    #binding.pry
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user

    if @recipe.save
      flash[:success] = "Your recipe was created successfully"
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was update successfully"
      redirect_to chef_path(@chef)
    else
      render :edit
    end
  end

  def like
    #пока прописано строго т к не аутентификации , параметр like передаем отдельно
    like= Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      if like.like
        @recipe.increment(:total_likes,1)
      else
        @recipe.decrement(:total_dislikes,1)
      end
      @recipe.save

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
    def set_recipe
      @recipe= Recipe.find(params[:id])
    end
    def require_same_user
      if current_user != @recipe.chef
        flash[:danger]= "You can only edit your own recipes"
        redirect_to recipes_path
      end

    end
end