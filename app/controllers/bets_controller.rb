class BetsController < ApplicationController
  def index
    @categories = Race.last.categories
    @ultims = my_boats('Ultim')
    @imocas = my_boats('IMOCA')
    @ocean_fifties = my_boats('Ocean Fifty')
    @class_40s = my_boats('Class 40')
    # @rhum_monos = my_boats('Rhum Mono')
    # @rhum_multis = my_boats('Rhum Multi')
  end

  def new
  end

  def create
    if bet_params['skipper_1'] == '' || bet_params['skipper_2'] == '' || bet_params['skipper_3'] == ''
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
  def my_boats(category)
    Bet.includes(:boat).where(user: current_user, boat: { category: category, race: Race.last }).sort_by(&:position)
  end

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
