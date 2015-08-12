require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.create(chefname: "Pedro Hulitos",email: "pedropedro@pedro.com")
    @recipe = @chef.recipes.build(name: "chicken parm", summary: "this is the best chicken parm recipe", description: "heat oil, add onions, add tomato sauce")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "name should not be to long" do
    @recipe.name = "a"*101
    assert_not @recipe.valid?
  end

  test "name should not be to short" do
    @recipe.name = "aааа"
    assert_not @recipe.valid?
  end

  test "summary should be present " do
    @recipe.summary = " "
    assert_not @recipe.valid?
  end

  test "summary lenght should not be to long" do
    @recipe.summary = "a"*151
    assert_not @recipe.valid?
  end

  test "summary lenght should not be to short" do
    @recipe.summary = "a"*9
    assert_not @recipe.valid?
  end

  test "description must be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end

  test "description should not be to long" do
    @recipe.description = "a"*501
    assert_not @recipe.valid?
  end

  test "description should not be to short" do
    @recipe.description = "a"*19
    assert_not @recipe.valid?
  end
end