require "verySimpleGame"

gameToWin = VerySimpleGame.new
numLoops = 1
while (gameToWin.winner.nil? and numLoops < 10) do
  numLoops += 1
  gameToWin.makeMove(gameToWin.legal_moves.first)
  p gameToWin.bord_state
end
p "done"
