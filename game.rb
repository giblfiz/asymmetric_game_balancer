class Game

  @@name = "Base Game Class"
  @@version ="0.1"


  def initialize
    @legal_number_of_players = 2
    @advantage_list = []
    @next_player_id = 1    
  end

  attr_accessor  :legal_number_of_players, :advantage_list, :next_player_id

  def setBoard
    #as a placeholder the board will simply be an array
    @board = [];
  end
  
  def name
    return @@name
  end

  def version
    return @@version
  end

  def winner
    return nil
  end

  def legal_moves
    return []
  end


end #close class game
