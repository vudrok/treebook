require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "a user should enter a first name" do
	  user = User.new
	  assert !user.save
	  assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name" do
	  user = User.new
	  assert !user.save
	  assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do
	  user = User.new
	  assert !user.save
	  assert !user.errors[:profile_name].empty?
	end

	test "a user should have a unique profile name" do
		user = User.new
		user.profile_name = 'vudrok'
		user.email = 'jose@4web.mx'
		user.first_name = 'jose'
		user.last_name = 'villalobos'
		user.password = 'password'
		user.password_confirmation = 'password'
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a profile name without spaces" do
		user = User.new(first_name: 'Vladimir', last_name: 'Putin', email: 'vladimirs@putin.ru')
		user.password = user.password_confirmation = 'password'
		
		user.profile_name = "My Profile With spaces"

		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("Must be formatted correctly.")
	end


	test "a user can have a correctly formatted profile name" do
		user = User.new(first_name: 'Vladimir', last_name: 'Putin', email: 'vladimirs@putin.ru')
		user.password = user.password_confirmation = 'password'

		user.profile_name = 'vladimirsh'
		assert user.valid?
	end
end