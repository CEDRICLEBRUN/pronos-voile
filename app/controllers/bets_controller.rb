class BetsController < ApplicationController
  def index
    @all_categories = Race.last.categories
  end

  def new
  end

  def create
    if bet_params['first_boat'] == '' ||
       bet_params['second_boat'] == '' ||
       bet_params['third_boat'] == ''

      flash.now.alert = 'Les 3 bateaux doivent être sélectionnés'
      render 'bets/new', status: :unprocessable_entity
    else
      # first bet
      first_boat = bet_params['first_boat']
      first_bet = create_bet(1, first_boat)

      # second bet
      second_boat = bet_params['second_boat']
      second_bet = create_bet(2, second_boat)

      # third bet
      third_boat = bet_params['third_boat']
      third_bet = create_bet(3, third_boat)

      if first_bet && second_bet && third_bet
        redirect_to bets_path, notice: 'Pari pris en compte !'
      else
        delete_incomplete_bets
        flash.now.alert = "Vous ne pouvez choisir un bateau qu'une seule fois"
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def bet_params
    params.permit(:first_boat, :second_boat, :third_boat, :category)
  end

  def create_bet(position, boat_name)
    bet = Bet.new
    bet.position = position
    bet.user = current_user
    bet.boat = Boat.where(name: boat_name).first
    bet.save
  end

  def delete_incomplete_bets
    Bet.includes(:boat).where(user: current_user, boat: { category: bet_params['category'] }).destroy_all
  end
end
