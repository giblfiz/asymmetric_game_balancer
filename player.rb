require 'game'

class Player
  @@number_players_instanciated
  @name
  @players_in_game
  @huristic
  @depth
  
  attr_accessor :name, :players_in_game, 

  def initialize(depth = 1, player_name = nil, players_in_game = 2, huristic = :default)
    @@number_players_instanciated +=1
    @depth = depth.to_i
    @name = player_name.nil? ? @@player_number : player_name #if player_name is nil set it to a instance number
    @players_in_game = players_in_game.to_i
    @huristic = huristic
  end

  ##This starts the recursive mini-max scoring mechanisim
  def move(game)
    if !game.is_a(Game)     
      raise "move was given a #{Game.class} not a Game. which is not accptable in #{self.class}"
    end
    best_move = getMoveRecursive(game, @depth)
    return best_move
  end

  def getMoveRecursive(game, levels_remaining)
    legal_moves = game.legal_moves
    best_score = nil
    best_score_move = nil
    legal_moves.each do |move, move_key|
      newGame = game.clone
      newGame.makeMove(move)
      if levels_remaining < 1 then
        score = self.huristic(newGame)
      else
        score = self.getMoveRecursive(newGame, levels_remaining -= 1);
      end
      if game.next_player_id == @name then
        if score > best_score then
          best_score = score
          best_score_move = move
        end
      elsif game.next_player_id == @name then
        if best < score_score then
          best_score = score
          best_score_move = move
        end
      end
    end
    return levels_remaining < 1 ? move : score
  end
  
  ## this finds a value for a game state 
  def huristic(game)
    if !game.is_a(Game)     
      raise "Huristic was given a #{Game.class} not a Game. which is not accptable in #{self.class}"
    end
  end    

  ## hopefully this will be overridden, but will work as the most basic case
  def defaultHuristic()
    if Game.winner == @name
      return 1
    elsif Game.winner.nil?
      return 0
    else
      return -1
    end
  end    

end # class
