function initializeGrid()
    for i = 1, gridSize do
        table.insert(grid, {})
        for k = 1, gridSize do
            table.insert(grid[i], {signed = false})
        end
    end
    local row, col = 0, 0
    local padding = SIZE/#grid
    for i = 1, #grid do
        for k = 1, #grid do
            grid[k][i].x = row
            grid[k][i].y = col
            grid[k][i].sign = nil
            col = col + padding
        end
        row = row + padding
        col = 0
    end
end

function resetGrid()
    for i = 1, #grid do
        for k = 1, #grid do
            grid[k][i].sign = nil
            grid[k][i].signed = false
        end
    end
end

function drawGrid()
    local padding = SIZE/#grid
    for i = 1, #grid do
        for k = 1, #grid do
            local pad = grid[k][i]
            if pad.signed == true then
                love.graphics.setColor(0.2, 1, 0.2, 0.1)
                love.graphics.rectangle('fill', pad.x+1, pad.y+1, padding-1, padding-1)
                if pad.sign == 'circle' then
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.circle('line', pad.x+padding/2, pad.y+padding/2, padding/4)
                elseif pad.sign == 'cross' then
                    local pad4 = padding/4
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.line(pad.x + pad4, pad.y + pad4, pad.x + 3*pad4, pad.y + 3*pad4)
                    love.graphics.line(pad.x + 3*pad4, pad.y + pad4, pad.x + pad4, pad.y + 3*pad4)
                end
            end
            love.graphics.setColor(0.1, 0.1, 0.1, 1)
            love.graphics.rectangle('line', pad.x, pad.y, padding, padding)
        end
    end
    if grid.selectPad then
        love.graphics.setColor(player == 1 and {0.8, 1, 1} or {1, 0.8, 1})
        love.graphics.rectangle('line', grid[grid.k][grid.i].x+2, grid[grid.k][grid.i].y+2,
        padding-4, padding-4)
    end
end


function selectPad()
    local k, i = 1, 1
    turn = 1

    function love.keypressed(key)
        if key == 'escape' then love.event.quit() end

        if endGame then
        
            if key == 'return' then
                resetGrid()
                endGame = false
                turn = 1
                k, i = 1, 1
                player = 1
            end
        
        else
            
            if key == 'up' or key == 'w' then
                if k == 1 then k = #grid
                else k = k - 1 end
            elseif key == 'down' or key == 's' then
                if k == #grid then k = 1
                else k = k + 1 end
            elseif key == 'left' or key == 'a' then
                if i == 1 then i = #grid
                else i = i - 1 end
            elseif key == 'right' or key == 'd' then
                if i == #grid then i = 1
                else i = i + 1 end
            elseif key == 'return' then
                if grid[k][i].signed == false then
                    grid[k][i].signed = true
                    grid[k][i].sign = player == 1 and 'cross' or 'circle'
                    player = -player
                    turn = turn + 1
                    checkWin()
                end
            end
        end
        grid.i = i
        grid.k = k
    end 
end

function checkWin()
    if turn > 5 then
        for i = 1, #grid do 
            if grid[i][1].sign == grid[i][2].sign and grid[i][1].sign == grid[i][3].sign then
                if grid[i][1].sign or grid[i][2].sign or grid[i][3].sign then
                    endGame = true
                    print("Primo")
                end
            end
        end
        for i = 1, #grid do 
            if grid[1][i].sign == grid[2][i].sign and grid[1][i].sign == grid[3][i].sign then
                if grid[1][i].sign or grid[2][i].sign or grid[3][i].sign then
                    endGame = true
                    print("secondo")
                end
            end
        end
        if grid[1][1].sign == grid[2][2].sign and grid[1][1].sign == grid[3][3].sign then
            if grid[1][1].sign or grid[2][2].sign or grid[3][3].sign then
                endGame = true
                print("terzo")
            end
        end
        if grid[1][3].sign == grid[2][2].sign and grid[1][3].sign == grid[3][1].sign then
            if grid[1][3].sign or grid[2][2].sign or grid[3][1].sign then
                endGame = true
                print("quarto")
            end
        end
    end
    if turn == 10 and not endGame then
        endGame = 'draw'
    end
end