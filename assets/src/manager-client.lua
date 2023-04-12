local fonts = {
    ['interbold'] = dxCreateFont('assets/fonts/interbold.ttf', 10);
    ['intermedium'] = dxCreateFont('assets/fonts/intermedium.ttf', 10);
    ['intersemibold'] = dxCreateFont('assets/fonts/intersemibold.ttf', 10);
    ['interthin'] = dxCreateFont('assets/fonts/interthin.ttf', 10);
    ['interregular'] = dxCreateFont('assets/fonts/interregular.ttf', 10);
    ['interlight'] = dxCreateFont('assets/fonts/interlight.ttf', 10);
    ['interextralight'] = dxCreateFont('assets/fonts/interextralight.ttf', 10);
    ['interextrabold'] = dxCreateFont('assets/fonts/interextrabold.ttf', 10);
    ['interblack'] = dxCreateFont('assets/fonts/interblack.ttf', 10);
}

local function managerDraw ()
    if (Opening == true) then Alpha = interpolateBetween(0, 0, 0, 255, 0, 0, ((getTickCount() - tick) / 900), 'Linear') else Alpha = interpolateBetween(255, 0, 0, 0, 0, 0, ((getTickCount() - tick) / 900), 'Linear') end
    
    drawSvgRectangle(341, 179, 1237, 722, 40, tocolor(22, 22, 22, Alpha), '#FF0000', 0, false)
end

    bindKey(configuration['GeneralSettings']['openKey'], 'down',
    function ()
        if not isEventHandlerAdded('onClientRender', root, managerDraw) then
            tick = getTickCount()
            Opening = true
            showCursor(true)
            addEventHandler('onClientRender', root, managerDraw)
        else
            if Opening == true then
                Opening = false
                showCursor(false)
                tick = getTickCount()
                setTimer(function()
                removeEventHandler('onClientRender', root, managerDraw)
                end, 1000, 1)
            end
        end
    end)
