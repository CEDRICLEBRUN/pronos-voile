require "test_helper"

class RaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'race should be valid' do
    race = races(:race_one)
    assert race.valid?
  end

  test 'race should not be valid' do
    race = Race.new
    assert_not race.valid?
  end
end
