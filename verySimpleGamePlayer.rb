require "verySimpleGame"
require "player"
class VerySimpleGamePlayer < Player


  def initialize(depth = 1, player_name = nil, players_in_game = 2, huristic = nil)
    @depth = depth.to_i
    @name = player_name.nil? ? @@number_players_instanciated : player_name #if player_name is nil set it to a instance number
    @players_in_game = players_in_game.to_i
    if !(huristic.nil?) then  
      @huristic = huristic
    else
      @huristic = :currentScore
    end
    @@number_players_instanciated +=1
  end

  def currentScore(game)
    if !game.is_a?(Game)     
      raise "Huristic was given a #{game.class} not a Game. which is not accptable in #{self.class}"
    end
    scores = game.bord_state[:scores]
    myScore = scores[@name] * 2;
    theirScore = scores.inject {|sum, item| sum + item} #this is basically scores.sum

    return myScore - theirScore
  end

end #close class
