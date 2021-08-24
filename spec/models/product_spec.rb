require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should contain all attributes" do
      @category = Category.new(name: "apparel")
      @product = @category.products.new
      @product.name = "sample item"
      @product.price = 1
      @product.quantity = 1
      @product.save

      expect(@product).to be_valid
    end
      it "should contain all attributes without category" do
        @category = nil
        @product = Product.new
        @product.name = "sample item"
        @product.price = 1
        @product.quantity = 1
        @product.save
  
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to eql(["Category can't be blank"])
      end

      it "should contain all attributes except name" do
        @category = Category.new(name: "apparel")
        @product = @category.products.new
        @product.name = nil
        @product.price = 1
        @product.quantity = 1
        @product.save
  
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to eql(["Name can't be blank"])
      end

      it "should contain all attributes except price" do
        @category = Category.new(name: "apparel")
        @product = @category.products.new
        @product.name = "sample item"
        @product.price = nil
        @product.quantity = 1
        @product.save
  
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to eql(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
      end

      it "should contain all attributes except quantity" do
        @category = Category.new(name: "apparel")
        @product = @category.products.new
        @product.name = "sample item"
        @product.price = 1
        @product.quantity = nil
        @product.save
  
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to eql(["Quantity can't be blank"])
      end
  end
end