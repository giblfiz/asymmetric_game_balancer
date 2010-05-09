require "game"
class VerySimpleGame < Game
  # In this game there is an array of 4 numbers (cards)
  # players take turns taking the numbers
  # The one with the highest score at the end wins

  @@name = "Very Simple Game"
  @@version ="0.1"

  def initialize(bord)
    @legal_number_of_players = 2
    @advantage_list = []
    @next_player_id = 0
    @player_scores = {0 => 0 , 1 => 0};
    setBord(bord)
    generateMoves
  end

  attr_accessor  :legal_number_of_players, :advantage_list, :next_player_id

  def setBord(bord = [ 4, 5, 6, 8] )
    #as a placeholder the bord will simply be an array
    @bord = bord
  end

  def generateMoves
    @moves = {}
    @bord.each_with_index do |value, key|
      @moves[key] = lambda{ 
        @player_scores[@next_player_id] += value
        @bord.delete_at(key)
      }
    end
  end
  
  def winner
    if @bord.empty? then

      if @player_scores[0] > @player_scores[1] then
        return "player 1"
      elsif @player_scores[0] < @player_scores[1] then
        return "player 2"
      else
        return "draw"
      end
    else  
      return nil
    end
  end

  def makeMove(moveId)
    if @moves.has_key?(moveId) then
      @moves[moveId].call
      @next_player_id += 1
      @next_player_id = @next_player_id.modulo(@legal_number_of_players)
      generateMoves
    else
      raise "the move #{moveId} does not exsist in #{@moves}" 
    end
    return self
  end

  def legal_moves
    return @moves.keys
  end

  def bord_state
    result = { :bord => @bord, :scores => @player_scores}
  end

end 



