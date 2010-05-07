require 'test/unit'
require 'game'
require 'player'

class TC_BasePlayerTest < Test::Unit::TestCase
  @myPlayer
  @myGame

  def setup
    @myPlayer = Player.new(1, :Alice, 2, :default)
    #Player.new(Depth, playername, Number Of Sides, <optional huristic> ) 

    @myGame = Game.new
  end

  def test_get_move
    assert(@myPlayer.respond_to?('move'), "The move function Does not exsist in the Player Class")
  end

  def test_get_move_recursive
    assert(@myPlayer.respond_to?('getMovesRecursive'), "The Recursive get move is not accessable")
  end

  def test_run_hurisitic
    assert(@myPlayer.respond_to?('huristic'), "The hurisitic is base is not defined")
    assert(@myPlayer.huristic(@myGame).nil? == true , "The game huristic did not return a value!")
  end

  def test_get_advantages
    assert(@myGame.respond_to?('advantage_list'), "The  advantage_list Getter Does not exsist in the Game Class")
    advantages = @myGame.advantage_list
    advantages.each do |advantage|
      assert(@myGame.respond_to?(advantage), "There is No Getter set for #{advantage}") 
    end
  end

  def test_get_winner
    assert(@myGame.respond_to?('winner'), "there is no Getter set for winner")
    assert(@myGame.winner == nil, "The game has been won when it starts")
  end


end
