require "test_helper"

class ProductTest < ActiveSupport::TestCase
  setup do
    @valid_attributes = {
      title: "Erlang",
      description: "Erlang ...",
      image_url: "erlang.gif",
      price: 99.99
    }
  end

  test "product attributes must be present" do
    product = Product.new
    assert product.invalid?
    %i(title description image_url price).each do |attr|
      assert product.errors[attr].any?
    end
  end

  test "product price must be positive" do
    product = Product.new(@valid_attributes.merge(price: -1))
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end
end
