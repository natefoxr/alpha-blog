require 'test_helper'

class Categorytest < ActiveSupport::TestCase

  test "category should be vaild" do 
    @category = Category.new(name: "Sports")
    assert @category.valid?
  end

end