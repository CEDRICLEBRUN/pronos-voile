require "test_helper"

class BoatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'boats should be valid' do
    boat = boats(:boat_one)
    other_boat = boats(:boat_two)
    assert boat.valid? && other_boat.valid?
  end

  test 'boat should not be valid' do
    boat = boats(:boat_three)
    assert_not boat.valid?
  end
end
