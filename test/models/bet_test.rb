require "test_helper"

class BetTest < ActiveSupport::TestCase
  test 'bet should be valid' do
    bet = bets(:bet_one)
    assert bet.valid?
  end

  test 'bet should be valid again' do
    bet = bets(:bet_two)
    assert bet.valid?
  end

  test 'bet should not be valid' do
    bet = Bet.new
    assert_not bet.valid?
  end
end
