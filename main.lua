function love.load()

  love.window.setTitle("PONGARDO LOVE EDITION")
  love.window.setMode(1600,800)
  
  gameState = "menu"
  
  scorePlayer1 = 0
  scorePlayer2 = 0
  
  reset("P1")
  
  font = love.graphics.newFont(70)
  
  fontMenu = love.graphics.newFont(150)
  
  fontPause = love.graphics.newFont(50)
  
  paddleSound = love.audio.newSource("paddleHit.wav", "static")
  
  scorePoint = love.audio.newSource("pointScore.mp3", "static")
  
  gamePause = false
  
  gameWon = false
  
end

function love.update(dt)
  if gameState == "playing" then
    if not gamePause then
      playerMovement(player1, "w", "s", dt)
      playerMovement(player2, "up", "down", dt)
      ballMovement(ball, dt)
      if scorePlayer1 == 3 then
        player1.speed = 0
        player2.speed = 0
        ball.speed = 0
        gameWon = true
      end
  
      if scorePlayer2 == 3 then
        player1.speed = 0
        player2.speed = 0
        ball.speed = 0
        gameWon = true
      end
    end
  end
end

function love.draw()
  if gameState == "menu" then
    love.graphics.setFont(fontMenu)
  
    love.graphics.setColor(255, 0, 0)
    
    love.graphics.print("PONG", (love.graphics.getWidth() / 2) - 500, 30)
    
    love.graphics.setColor(0, 0, 255)
    
    love.graphics.print("ARDO", (love.graphics.getWidth() / 2), 30)
    
    love.graphics.setFont(font)
    
    love.graphics.setColor(255, 255, 255)
    
    love.graphics.print("Love2D edition", (love.graphics.getWidth() / 2) - 310, 200)
    
    love.graphics.setFont(fontPause)
    
    love.graphics.setColor(255, 255, 0)
    
    love.graphics.print("The first player to get 3 points wins!", (love.graphics.getWidth() / 2) - 500, 300)
    
    love.graphics.setColor(0, 0, 255)
    
    love.graphics.print("Control PLayer 1 with 'W' and 'S'", (love.graphics.getWidth() / 2) - 450, 400)
    
    love.graphics.setColor(255, 0, 0)
    
    love.graphics.print("Control PLayer 2 with 'UP' and 'DOWN' arrow", (love.graphics.getWidth() / 2) - 600, 500)
    
    love.graphics.setColor(0, 255, 0)
    
    love.graphics.print("Press 'ENTER' to pause the game", (love.graphics.getWidth() / 2) - 450, 600)
    
    love.graphics.setFont(font)
    
    love.graphics.setColor(0, 255, 255)
    
    love.graphics.print("Press 'SPACE' to start!", (love.graphics.getWidth() / 2) - 400, 700)
  end
  
  if gameState == "playing" then
    love.graphics.setFont(font)
  
    love.graphics.setColor(255, 255, 255)
  
    love.graphics.rectangle("fill", (love.graphics.getWidth() / 2) - 5, 0, 10, 800)
  
    love.graphics.print(scorePlayer1, (love.graphics.getWidth() / 2) - 250, 50)
    love.graphics.print(scorePlayer2, (love.graphics.getWidth() / 2) + 150, 50)
    
    love.graphics.setColor(0, 0, 255)
  
    love.graphics.rectangle("fill", player1.x, player1.y, player1.width, player1.height)
  
    love.graphics.setColor(255, 0, 0)
 
    love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
  
    love.graphics.setColor(0, 255, 0)
 
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
  
    if gamePause then
      love.graphics.setFont(fontPause)
      love.graphics.setColor(255, 255, 255)
      love.graphics.rectangle("fill", (love.graphics.getWidth() / 2) - 425, (love.graphics.getHeight() / 2) - 165, 850, 300)
      love.graphics.setColor(0, 0, 0)
      love.graphics.print("Game is PAUSED", (love.graphics.getWidth() / 2) - 215, 250)
      love.graphics.setColor(255, 0, 255)
      love.graphics.print("Press ENTER to resume playing", (love.graphics.getWidth() / 2) - 395, 350)
      love.graphics.print("Press ESCAPE to EXIT", (love.graphics.getWidth() / 2) - 275, 450)
    end
    
    if gameWon then
      love.graphics.setFont(fontPause)
      love.graphics.setColor(255, 255, 255)
      love.graphics.rectangle("fill", (love.graphics.getWidth() / 2) - 325, (love.graphics.getHeight() / 2) - 65, 650, 200)
      if scorePlayer1 == 3 then
        love.graphics.setColor(0, 0, 255)
        love.graphics.print("Player 1 WON", (love.graphics.getWidth() / 2) - 180, 350)
      end
      if scorePlayer2 == 3 then
        love.graphics.setColor(255, 0, 0)
        love.graphics.print("Player 2 WON", (love.graphics.getWidth() / 2) - 180, 350)
      end
      love.graphics.setColor(255, 0, 255)
      love.graphics.print("Press ESCAPE to EXIT", (love.graphics.getWidth() / 2) - 275, 450)
    end
  end
end

function love.keypressed(key, scancode, isrepeat)
  if gameState == "menu" then
    if key == "space" then
      gameState = "playing"
    end
  end

  if gameState == "playing" then
    if key == "return" then
      gamePause = not gamePause
    end
    if key == "escape" then
      love.event.quit()
    end
  end
end

function playerMovement(player, upMovement, downMovement, dt)
  
  if love.keyboard.isDown(upMovement) and player.y >= 0 then 
    player.y = player.y - player.speed * dt
  end
  
  if love.keyboard.isDown(downMovement) and (player.y + player.height) <= love.graphics.getHeight() then 
    player.y = player.y + player.speed * dt
  end
  
end

function ballMovement(ball, dt)
  
  if ball.right then
    ball.x = ball.x + ball.speed * dt
  else
    ball.x = ball.x - ball.speed * dt
  end
  
  if ball.up then
    ball.y = ball.y - ball.speed * dt
  else
    ball.y = ball.y + ball.speed * dt
  end
  
  if (ball.x) >= (player1.x) 
  and (ball.x) <= (player1.x + player1.width) 
  and (ball.y - ball.radius) <= (player1.y + player1.height) 
  and (ball.y - ball.radius) >= (player1.y) then
    love.audio.play(paddleSound)
    ball.up = false
  end
  
  if ball.x >= player1.x 
  and ball.x <= (player1.x + player1.width) 
  and (ball.y + ball.radius) <= player1.y 
  and (ball.y + ball.radius) >= (player1.y + player1.height) 
  then
    love.audio.play(paddleSound)
    ball.up = true
  end
  
  if ball.x >= player2.x 
  and ball.x <= (player2.x + player2.width) 
  and (ball.y - ball.radius) <= (player2.y + player2.height) 
  and (ball.y - ball.radius) >= player2.y 
  then
    love.audio.play(paddleSound)
    ball.up = false
  end
  
  if ball.x >= player2.x 
  and ball.x <= (player2.x + player2.width) 
  and (ball.y + ball.radius) <= player2.y 
  and (ball.y + ball.radius) >= (player2.y + player2.height) 
  then
    love.audio.play(paddleSound)
    ball.up = true
  end
  
  if (ball.x - ball.radius) <= (player1.x + player1.width) 
  and (ball.x - ball.radius) >= player1.x
  and ball.y >= player1.y
  and ball.y <= player1.y + player1.height 
  then
    love.audio.play(paddleSound)
    ball.right = true
    ball.speed = ball.speed + 50
  end
  
  if (ball.x + ball.radius) >= player2.x 
  and (ball.x + ball.radius) <= (player2.x + player1.width)
  and ball.y >= player2.y
  and ball.y <= player2.y + player2.height 
  then
    love.audio.play(paddleSound)
    ball.right = false
    ball.speed = ball.speed + 50 
  end
  
  if (ball.x + ball.radius) >= love.graphics.getWidth() then
    reset("P1")
    love.audio.play(scorePoint)
    scorePlayer1 = scorePlayer1 + 1
  end
  
  if (ball.x - ball.radius) <= 0 then
    reset("P2")
    love.audio.play(scorePoint)
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
  player1.speed = 200
  
  
  player2 = {}
  player2.x = 1500
  player2.y = 300
  player2.width = 50
  player2.height = 250
  player2.speed = 200
  
  ball = {}
  ball.x = love.graphics.getWidth() / 2
  ball.y = love.graphics.getHeight() / 2
  ball.radius = 20
  
  if playerPoints == "P1" then
    ball.right = false
  else
    ball.right = true
  end
  
  ball.up = false
  ball.speed = 200
  
end