require "test_helper"

class CrewTest < ActiveSupport::TestCase
  test 'crew should be valid' do
    crew = crews(:crew_one)
    assert crew.valid?
  end

  test 'crew should not be valid' do
    crew = crews(:crew_two)
    assert_not crew.valid?
  end
end
