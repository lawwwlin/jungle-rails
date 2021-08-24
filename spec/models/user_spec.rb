require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should contain all attributes" do
      @user = User.new
      @user.first_name = "first"
      @user.last_name = "last"
      @user.email = "email.email.com"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save

      expect(@user).to be_valid
    end

    it "should not be valid without first name" do
      @user = User.new
      @user.first_name = nil
      @user.last_name = "last"
      @user.email = "email.email.com"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql(["First name can't be blank"])
    end

    it "should not be valid without last name" do
      @user = User.new
      @user.first_name = "first"
      @user.last_name = nil
      @user.email = "email.email.com"
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql(["Last name can't be blank"])
    end

    it "should not be valid without email" do
      @user = User.new
      @user.first_name = "first"
      @user.last_name = "last"
      @user.email = nil
      @user.password = "password"
      @user.password_confirmation = "password"
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql(["Email can't be blank"])
    end

    it "should not be valid without password" do
      @user = User.new
      @user.first_name = "first"
      @user.last_name = "last"
      @user.email = "email@email.com"
      @user.password = nil
      @user.password_confirmation = "password"
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql(["Password can't be blank", "Password is too short (minimum is 6 characters)"])
    end

    it "should not be valid without password confirmation" do
      @user = User.new
      @user.first_name = "first"
      @user.last_name = "last"
      @user.email = "email@email.com"
      @user.password = "password"
      @user.password_confirmation = nil
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql(["Password confirmation can't be blank"])
    end

    it "should not be valid when password confirmation is wrong" do
      @user = User.new
      @user.first_name = "first"
      @user.last_name = "last"
      @user.email = "email@email.com"
      @user.password = "password"
      @user.password_confirmation = "passwords"
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql(["Password confirmation doesn't match Password"])
    end

    it "should not be valid when email is not unique" do
      @user1 = User.new
      @user1.first_name = "first"
      @user1.last_name = "last"
      @user1.email = "email@email.com"
      @user1.password = "password"
      @user1.password_confirmation = "password"
      @user1.save

      @user2 = User.new
      @user2.first_name = "second"
      @user2.last_name = "last"
      @user2.email = "EMAIL@EMAIL.COM"
      @user2.password = "passwords"
      @user2.password_confirmation = "passwords"
      @user2.save

      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to eql(["Email has already been taken"])
    end

    it "should not be valid when password is too short" do
      @user = User.new
      @user.first_name = "first"
      @user.last_name = "last"
      @user.email = "email@email.com"
      @user.password = "pass"
      @user.password_confirmation = "pass"
      @user.save

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql(["Password is too short (minimum is 6 characters)"])
    end
  end

  describe '.authenticate_with_credentials' do
    it 'can login with registered email and password' do
      @user = User.create(first_name: "first", last_name: "last", email: "email@email.com", password:"password", password_confirmation:"password")
      expect(User.authenticate_with_credentials("email@email.com", "password")).to eq(@user)
    end

    it 'can login with registered email and password, with white space around email input' do
      @user = User.create(first_name: "first", last_name: "last", email: "email@email.com", password:"password", password_confirmation:"password")
      expect(User.authenticate_with_credentials("  email@email.com  ", "password")).to eq(@user)
    end

    it 'can login with registered email and password, with capitalized email input' do
      @user = User.create(first_name: "first", last_name: "last", email: "email@email.com", password:"password", password_confirmation:"password")
      expect(User.authenticate_with_credentials("  EMAIL@EMAIL.COM  ", "password")).to eq(@user)
    end

  end

end