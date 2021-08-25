require 'rails_helper'

RSpec.feature "Visitor navigates to login page and logs in with correct credentials.", type: :feature, js: true do

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
    
    @user = User.create!(
      first_name: "First",
      last_name: "Last",
      email: "email@email.com",
      password: "securepassword",
      password_confirmation: "securepassword"
    )
  end

  scenario "Log in with email and password" do
    visit root_path
    click_on "Login"
    fill_in "Email:", with: "email@email.com"
    fill_in "Password:", with: "securepassword"
    save_screenshot
    click_on "Sign in"

    expect(page).to have_content 'Signed in as email@email.com'
    expect(page).to have_css 'article.product', count: 10

    # uncomment to see screenshot
    # save_screenshot
  end
end