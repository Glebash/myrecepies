require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "Pedro Hulitos",email: "pedropedro@pedro.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chefname must be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname must be enought long" do
    @chef.chefname="a"*2
    assert_not @chef.valid?
  end

  test "chefname must be not longer then" do
    @chef.chefname="a"*41
    assert_not @chef.valid?
  end

  test "email must be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email must be within bounds" do
    @chef.email = "a"*101+"@example.com"
    assert_not @chef.valid?
  end

  test "email must be uniq" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email validations should accept valid addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.helllo.org user@example.com fist.last@eeem.au fuck@wad.ru]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end

  test "email validations should reject invalid addresses" do
    invalid_addresses = %w[usereee.com R_TDD-DS@eee..org user@example. com fist.lasteeem.au fuck@wa_d.ru]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be invalid'
    end
  end
end
