require 'test/unit'
require 'game'

class TC_BaseGameTest < Test::Unit::TestCase
  @myGame;

  def setup
    @myGame = Game.new
  end

  def test_get_name
    assert(@myGame.respond_to?('name'), "The name Getter Does not exsist in the Game Class")
    assert(@myGame.name.nil? == false , "The game does not have a name Set!")
  end

  def test_get_version
    assert(@myGame.respond_to?('version'), "The version Getter Does not exsist in the Game Class")
    assert(@myGame.version.nil? == false , "The game does not have a version Set!")
  end

  def test_legal_number_of_players
    assert(@myGame.respond_to?('legal_number_of_players'), "The legal_number_of_players Getter Does not exsist in the Game Class")
    assert(@myGame.legal_number_of_players.nil? == false , "The game does not Allow any players!")
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
