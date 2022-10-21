function love.load()
  
  love.window.setTitle("PONGARDO LOVE EDITION")
  love.window.setMode(1600,800)
  
  player1 = {}
  player1.x = 50
  player1.y = 300
  player1.width = 50
  player1.height = 250
  player1.speed = 2
  
  
  player2 = {}
  player2.x = 1500
  player2.y = 300
  player2.width = 50
  player2.height = 250
  player2.speed = 2
  
end
