require 'rails_helper'

RSpec.feature "Visitor navigates to product detail page from home page by clicking on a product.", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )

    end
  end

  scenario "Click on the first product" do
    visit root_path
    first("article.product").hover.click_on "Details"
    
    expect(page).to have_css '.product-detail', count: 1

    # uncomment to see screenshot
    # save_screenshot
  end
end