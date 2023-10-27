class BetsController < ApplicationController
  def index
    @all_categories = Race.last.categories
    @my_bets = all_my_bets
    @starting_time = Time.new(2023,10,29,13,05)
  end

  def new
    if Time.zone.now > Time.new(2023,10,29,13,05)
      redirect_to bets_path, notice: 'Le départ est donné, tu ne peux plus parier !'
    end
  end

  def create
    delete_bets
    bet_creation
  end

  private

  def all_my_bets
    categories = Race.all_categories
    my_bets = {}
    categories.each do |category|
      my_bets[category['name']] = Bet.get_bets_by_category(category['name'], current_user)
    end
    my_bets
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

  def delete_bets
    Bet.includes(:boat).where(user: current_user, boat: { category: bet_params['category'] }).destroy_all
  end

  def bet_creation
    if bet_params['first_boat'] == '' ||
      bet_params['second_boat'] == '' ||
      bet_params['third_boat'] == ''

     flash.now.alert = 'Les 3 bateaux doivent être sélectionnés'
     render :new, status: :unprocessable_entity
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
       delete_bets
       flash.now.alert = "Vous ne pouvez choisir un bateau qu'une seule fois"
       render :new, status: :unprocessable_entity
     end
   end
  end
end
