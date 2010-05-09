require 'game'

class Player
  @@number_players_instanciated = 0
  @name
  @players_in_game
  @huristic
  @depth
  
  attr_accessor :name, :players_in_game , :huristic

  def initialize(depth = 1, player_name = nil, players_in_game = 2, huristic = nil)
    @depth = depth.to_i
    @name = player_name.nil? ? @@number_players_instanciated : player_name #if player_name is nil set it to a instance number
    @players_in_game = players_in_game.to_i
    if !(huristic.nil?) then  
      @huristic = huristic
    else
      @huristic = :winLose
    end
    @@number_players_instanciated +=1
  end

  ##This starts the recursive mini-max scoring mechanisim
  def move(game, huristic = nil)
    huristic = huristic.nil? ? @huristic : huristic
    if !game.is_a?(Game)     
      raise "move was given a #{Game.class} not a Game. which is not accptable in #{self.class}"
    end
    legal_moves = game.legal_moves
    
    if legal_moves.none? then
      return nil
    end
    
    best_score = nil
    best_move = nil
    legal_moves.each do |move, move_key|
      move_score = moveRecursive(game.clone.makeMove(move), @depth, huristic)
      best_move  = best_score.nil? || best_score > move_score ? best_move : move
      best_score = best_score.nil? || best_score > move_score ? best_score : move_score
    end
    return best_move
  end

  def moveRecursive(game, levels_remaining, huristic = nil)
    huristic = huristic.nil? ? @huristic : huristic
    p( "hurisitic val was #{huristic} default is #{@hurisitc}")
    legal_moves = game.legal_moves
    best_score = nil
    best_score_move = nil
    
    #if there are no legal moves left, then we should evaluate and return
    if legal_moves.none? then
      return self.send(huristic, game)
    end

    #otherwise we should figure out the score for each of the remaining moves
    legal_moves.each do |move, move_key|
      newGame = game.clone.makeMove(move)
      if levels_remaining < 1 then
        p "trying with a huristic value of #{huristic}" 
        begin
          score = self.send(huristic, newGame)
        rescue TypeError => ex
          p "There seems to have been a problem with #{huristic} of type #{ex}, soldiering on with value of 0"
          score = 0
        end
      else
        score = self.moveRecursive(newGame, levels_remaining -= 1, huristic);
      end
      if game.next_player_id == @name then
        if best_score.nil? || score > best_score then
          best_score = score
        end
      elsif game.next_player_id != @name then
        if best_score.nil? || score < best_score then
          best_score = score
        end
      end
    end
    return best_score
  end
  
  ## hopefully they will come up with a better huristic than than this, but it should always work if nessisary
  def winLose(game)
    if !game.is_a?(Game)     
      raise "Huristic was given a #{game.class} not a Game. which is not accptable in #{self.class}"
    end
    if game.winner == @name
      return 1
    elsif game.winner.nil?
      return 0
    else
      return -1
    end
  end    

end # class
