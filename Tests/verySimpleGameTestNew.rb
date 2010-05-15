require 'test/unit'
require 'verySimpleGamePlayer'
class TC_BaseGameTest < Test::Unit::TestCase

  def test_deepClone
    clonedGame = VerySimpleGame.new([2,1])
    gameClone = clonedGame.deepClone
    game = VerySimpleGame.new([2,1])


    assert_equal(gameClone.class, VerySimpleGame)
    assert_equal(clonedGame.class, VerySimpleGame)
    assert_equal(game.class, VerySimpleGame)

    assert_equal(game.bord_state, clonedGame.bord_state)
    assert_equal(game.bord_state, gameClone.bord_state)
    assert_equal(gameClone.bord_state, clonedGame.bord_state)

  end

  def test_vsg_setup
    game = VerySimpleGame.new([3,2,1])
    assert_equal(game.list_of_players, [:red, :black])

    assert_equal(game.bord_state, {
                    :bord => [3,2,1],
                    :scores =>{
                      :red => 0,
                      :black =>0},
                    :nextPlayerId => :red
                  }, "bord_state not as expected")
    assert_equal(game.legal_moves, [0,1,2])
    game.makeMove(0)
    assert_equal(game.legal_moves, [0,1])
    assert_equal(game.next_player_id, :black)
    assert_equal(game.bord_state[:scores][:red], 3)
    assert_equal(game.bord_state[:bord], [2,1])
  end


  def test_huristic
    game = VerySimpleGame.new([3,2,1])

    players = {
      :red => VerySimpleGamePlayer.new(game.list_of_players[0]),
      :black => VerySimpleGamePlayer.new(game.list_of_players[1])
    }
    
    assert_equal(players[:red].currentScore(game), 0 )
    assert_equal(players[:black].currentScore(game), 0 )
    
    assert_equal(game.next_player_id, :red, "if this is not the case, then the next tests will fail")

    game.makeMove(game.legal_moves[0])
    assert_equal(players[:red].currentScore(game), 3 )
    assert_equal(players[:black].currentScore(game), -3 )

    game.makeMove(game.legal_moves[1])
    assert_equal(players[:red].currentScore(game), 2 )
    assert_equal(players[:black].currentScore(game), -2 )

    game.makeMove(game.legal_moves[0])
    assert_equal(players[:red].currentScore(game), 4 )
    assert_equal(players[:black].currentScore(game), -4 )

    assert_equal(game.winner, :red)

  end
  
  def test_move_recursive
    game = VerySimpleGame.new([2,3,1])
    players = {
      :red => VerySimpleGamePlayer.new(game.list_of_players[0]),
      :black => VerySimpleGamePlayer.new(game.list_of_players[1])
    }
    assert_equal(game.next_player_id, :red, "if this is not the case, then the next tests will fail")

    assert_raise(NoMethodError) do
      players[:red].moveRecursive(game,0,:noSuchHuristic)
    end

    assert_equal(players[:red].currentScore(game), 0)

    assert_equal(players[:red].moveRecursive(game,0,:currentScore), 0, "should go right to huristic")
    assert_equal(players[:black].moveRecursive(game,0,:currentScore), 0, "should go right to huristic")

    assert_equal(players[:red].moveRecursive(game, 1, :currentScore), 3 )
    assert_equal(players[:black].moveRecursive(game, 1, :currentScore), -3)

    assert_equal(players[:red].moveRecursive(game, 2, :currentScore), 1 )
    assert_equal(players[:black].moveRecursive(game, 2, :currentScore), -1)

    assert_equal(players[:red].moveRecursive(game, 3, :currentScore), 2 )
    assert_equal(players[:black].moveRecursive(game, 3, :currentScore), -2)

  end

  def test_move
    game = VerySimpleGame.new([2,3,1])
    players = {
      :red => VerySimpleGamePlayer.new(game.list_of_players[0]),
      :black => VerySimpleGamePlayer.new(game.list_of_players[1])
    }
    assert_equal(game.next_player_id, :red, "if this is not the case, then the next tests will fail")
    
    #default depth is 1, should be enough to spot the highest number
    assert_equal(players[:red].move(game), 1)
    assert_raise(GameplayError) do 
      players[:black].move(game)
    end
    
    game.makeMove(players[:red].move(game))
    assert_equal(game.legal_moves, [0,1])
    assert_equal(game.bord_state, {
                    :bord => [2,1],
                    :scores =>{
                      :red => 3,
                      :black =>0},
                    :nextPlayerId => :black
                  }, "bord_state not as expected")
    
    assert_equal(players[:black].move(game), 0)
    assert_raise(GameplayError) do 
      players[:red].move(game)
    end

  end


end
