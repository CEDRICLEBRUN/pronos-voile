require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'user should be valid' do
    user = users(:user_one)
    assert user.valid?
  end

  test 'user should not be valid' do
    user = User.new
    assert_not user.valid?
  end
end
