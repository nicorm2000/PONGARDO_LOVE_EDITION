function love.load()
  
  love.window.setTitle("PONGARDO LOVE EDITION")
  love.window.setMode(1600,800)
  
  scorePlayer1 = 0
  scorePlayer2 = 0
  
  reset("P1")
  
  font = love.graphics.newFont(70)
  
end

function love.update(dt)
  
  playerMovement(player1, "w", "s")
  playerMovement(player2, "up", "down")
  ballMovement(ball)
  
end

function love.draw()
  
  love.graphics.setFont(font)
  
  love.graphics.setColor(255, 255, 255)
  
  love.graphics.print(scorePlayer1, (love.graphics.getWidth() / 2) - 250, 50)
  love.graphics.print(scorePlayer2, (love.graphics.getWidth() / 2) + 150, 50)
  
  love.graphics.rectangle("fill", player1.x, player1.y, player1.width, player1.height)
  love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
  
  love.graphics.rectangle("fill", (love.graphics.getWidth() / 2) - 5, 0, 10, 800)
  
  love.graphics.setColor(255, 0, 0)
  love.graphics.circle("fill", ball.x, ball.y, ball.radius)
  
end

function playerMovement(player, upMovement, downMovement)
  
  if love.keyboard.isDown(upMovement) and player.y >= 0 then 
    player.y = player.y - player.speed
  end
  
  if love.keyboard.isDown(downMovement) and (player.y + player.height) <= love.graphics.getHeight() then 
    player.y = player.y + player.speed
  end
  
end

function ballMovement(ball)
  
  if ball.right then
    ball.x = ball.x + ball.speed
  else
    ball.x = ball.x - ball.speed
  end
  
  if ball.up then
    ball.y = ball.y - ball.speed
  else
    ball.y = ball.y + ball.speed
  end
  
  if (ball.x) >= (player1.x) 
  and (ball.x) <= (player1.x + player1.width) 
  and (ball.y - ball.radius) <= (player1.y + player1.height) 
  and (ball.y - ball.radius) >= (player1.y) then
    ball.up = false
  end
  
  if ball.x >= player1.x 
  and ball.x <= (player1.x + player1.width) 
  and (ball.y + ball.radius) <= player1.y 
  and (ball.y + ball.radius) >= (player1.y + player1.height) 
  then
    ball.up = true
  end
  
  if ball.x >= player2.x 
  and ball.x <= (player2.x + player2.width) 
  and (ball.y - ball.radius) <= (player2.y + player2.height) 
  and (ball.y - ball.radius) >= player2.y 
  then
    ball.up = false
  end
  
  if ball.x >= player2.x 
  and ball.x <= (player2.x + player2.width) 
  and (ball.y + ball.radius) <= player2.y 
  and (ball.y + ball.radius) >= (player2.y + player2.height) 
  then
    ball.up = true
  end
  
  if (ball.x - ball.radius) <= (player1.x + player1.width) 
  and (ball.x - ball.radius) >= player1.x
  and ball.y >= player1.y
  and ball.y <= player1.y + player1.height 
  then
    ball.right = true
    ball.speed = ball.speed + 0.5
  end
  
  if (ball.x + ball.radius) >= player2.x 
  and (ball.x + ball.radius) <= (player2.x + player1.width)
  and ball.y >= player2.y
  and ball.y <= player2.y + player2.height 
  then
    ball.right = false
    ball.speed = ball.speed + 0.5
  end
  
  if (ball.x + ball.radius) >= love.graphics.getWidth() then
    reset("P1")
    scorePlayer1 = scorePlayer1 + 1
  end
  
  if (ball.x - ball.radius) <= 0 then
    reset("P2")
    scorePlayer2 = scorePlayer2 + 1
  end
  
  if (ball.y + ball.radius) >= love.graphics.getHeight() then
    ball.up = true
  end
  
  if (ball.y - ball.radius) <= 0 then
    ball.up = false
  end
  
end

function reset(playerPoints)
  
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
  
  ball = {}
  ball.x = love.graphics.getWidth() / 2
  ball.y = love.graphics.getHeight() / 2
  ball.radius = 20
  ball.right = false
  ball.up = false
  ball.speed = 2
  
end
