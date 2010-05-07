require 'test/unit'
require 'verySimpleGame'
class TC_BaseGameTest < Test::Unit::TestCase
  @myGame;

  def setup
    @myGame = VerySimpleGame.new
  end

  def test_get_advantage_list
    assert(@myGame.respond_to?('advantage_list'), "The  advantage_list Getter Does not exsist in the Game Class")
  end

  def test_get_advantages
    assert(@myGame.respond_to?('advantage_list'), "The  advantage_list Getter Does not exsist in the Game Class")
    advantages = @myGame.advantage_list
    advantages.each do |advantage|
      assert(@myGame.respond_to?(advantage), "There is No Getter set for #{advantage}") 
    end
  end

  def test_get_moves
    assert(@myGame.respond_to?('legal_moves'), "there is no Getter for legal moves")
    assert(@myGame.legal_moves.empty? == false, "The game starts with no legal moves")
  end

  def test_get_next_player_id
    assert(@myGame.respond_to?('next_player_id'), "There is no Getter set for next_player_id")
    next_player_id = @myGame.next_player_id
    moves = @myGame.legal_moves
    @myGame.makeMove(moves.first)
    assert(@myGame.next_player_id != next_player_id, 
           "The Same player is being told to go twice in a row old:new #{next_player_id} : #{@myGame.next_player_id}")
  end

  def test_get_bord_state
    assert(@myGame.respond_to?('bord_state'), "There is no Getter set for bord_state")
    boardState = @myGame.bord_state
    assert(boardState[:bord].instance_of?(Array), "did not get a proper bord back (not an array)")
    assert(boardState[:scores].instance_of?(Hash), "did not get a proper Score Back (not a hash)")
  end

  def test_play_to_win
    gameToWin = VerySimpleGame.new
    numLoops = 1
    while (gameToWin.winner.nil? and numLoops < 10) do
      numLoops += 1
      assert(gameToWin.legal_moves.empty? == false, "the game is not won, but there are no more legal moves")
      gameToWin.makeMove(gameToWin.legal_moves.first)
    end
    assert(numLoops < 10, "The game loop was aborted to prevent infinate loops after #{numLoops}")
    assert(gameToWin.legal_moves.empty?, "the game is won, but there are still legal moves")
#    gameToWin
#    assert(gameToWin.winner
  end

end
