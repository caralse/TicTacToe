require("Dependencies")

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle("Tic Tac Toe")
    love.window.setMode(SIZE, SIZE, {
        resizable = false,
        fullscreen = false,
        vsync = true
    })
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2, 1)
    initializeGrid()
    selectPad()
end

function love.draw()
    drawGrid()
    if endGame then
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.rectangle('fill', 0, 0, SIZE, SIZE)
        if endGame == 'draw' then
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf("DRAW! \n Press Enter to Restart \n Press esc to quit", 0, SIZE/2, SIZE, 'center')
        else
            local text = player == -1 and "PLAYER 1 WINS!" or "PLAYER 2 WINS!"
            text = text .. "\n Press Enter to Restart \n Press esc to quit"
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf(text, 0, SIZE/2, SIZE, 'center')
        end
    end
end