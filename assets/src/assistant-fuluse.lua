local sW, sH = guiGetScreenSize()
resX, resY = 1920, 1080

function aToR( X, Y, sX, sY)
	local xd = X/resX or X
	local yd = Y/resY or Y
	local xsd = sX/resX or sX
	local ysd = sY/resY or sY
	return xd*sW, yd*sH, xsd*sW, ysd*sH
end

_dxDrawRectangle = dxDrawRectangle
function dxDrawRectangle( x, y, w, h, color, post)
	local x, y, w, h = aToR( x, y, w, h)

	return _dxDrawRectangle( x, y, w, h, color, post)
end

_dxDrawText = dxDrawText
function dxDrawText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wbreak, post, colorcode, sPP, fR, fRCX, fRCY)
	local x, y, w, h = aToR( x, y, w, h)

	return _dxDrawText( text, x, y, w, h, color, (sH / resY) * scale, font, alignX, alignY, clip, wbreak, post, colorcode, sPP, fR, fRCX, fRCY)
end

_dxDrawImage = dxDrawImage
function dxDrawImage( x, y, w, h, image, rot, rotcox, rotcoy, color, post)
	local x, y, w, h = aToR( x, y, w, h)

	return _dxDrawImage( x, y, w, h, image, rot, rotcox, rotcoy, color, post)
end

_dxDrawImageSection = dxDrawImageSection
function dxDrawImageSection( x, y, w, h, u, v, us, uz, image, rot, rotcox, rotcoy, color, post)
	local x, y, w, h = aToR( x, y, w, h)

	return _dxDrawImageSection( x, y, w, h, u, v, us, uz, image, rot, rotcox, rotcoy, color, post)
end

_dxDrawLine = dxDrawLine
function dxDrawLine( startX, startY, endX, endY, color, width, postGUI)
	local startX, startY, endX, endY = aToR( startX, startY, endX, endY)

	return _dxDrawLine( startX, startY, endX, endY, color, width, postGUI)
end

function drawButton(x, y, w, h, text, color, next_color, utils, postGUI)
	if (isCursorOnElement(x, y, w, h)) then
		dxDrawRectangle(x, y, w, h, tocolor(next_color[1] or 255, next_color[2] or 255, next_color[3] or 255, next_color[4] or 255), postGUI);
	else
		dxDrawRectangle(x, y, w, h, tocolor(color[1] or 255, color[2] or 255, color[3] or 255, color[4] or 255), postGUI);
	end
	if (text) then
		dxDrawText(text, x, y, x + w, y + h, tocolor(255, 255, 255), utils[1] or 1, utils[2] or "default", utils[3] or "center", utils[4] or "center", true, true, postGUI);
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------

local x,y = guiGetScreenSize()
function isCursorOnElement(x,y,w,h)
    if (isCursorShowing()) then
	    local mx,my = getCursorPosition()
     	local fullx,fully = guiGetScreenSize()
	    cursorx,cursory = mx*fullx,my*fully
	    if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
	    	return true
	    else
		    return false
		end
	end
end

function drawButton(x, y, w, h, text, color, next_color, utils, postGUI)
	local buttonX, buttonY, buttonW, buttonH = aToR(x, y, w, h) 
	if (isCursorOnElement(buttonX, buttonY, buttonW, buttonH)) then
		dxDrawRectangle(x, y, w, h, tocolor(next_color[1] or 255, next_color[2] or 255, next_color[3] or 255, next_color[4] or 255), postGUI);
	else
		dxDrawRectangle(x, y, w, h, tocolor(color[1] or 255, color[2] or 255, color[3] or 255, color[4] or 255), postGUI);
	end
	if (text) then
		dxDrawText(text, x, y, x + w, y + h, tocolor(255, 255, 255), utils[1] or 1, utils[2] or "default", utils[3] or "center", utils[4] or "center", true, true, postGUI);
	end
end

local buttons = {}

function drawSvgRectangle(x, y, width, height, radius, color, colorStroke, sizeStroke, postGUI)
    colorStroke = tostring(colorStroke)
    sizeStroke = tostring(sizeStroke)

    if (not buttons[radius]) then
        local raw = string.format([[
            <svg width='%s' height='%s' fill='none' xmlns='http://www.w3.org/2000/svg'>
                <mask id='path_inside' fill='#FFFFFF' >
                    <rect width='%s' height='%s' rx='%s' />
                </mask>
                <rect opacity='1' width='%s' height='%s' rx='%s' fill='#FFFFFF' stroke='%s' stroke-width='%s' mask='url(#path_inside)'/>
            </svg>
        ]], width, height, width, height, radius, width, height, radius, colorStroke, sizeStroke)
        buttons[radius] = svgCreate(width, height, raw)
    end
    if (buttons[radius]) then -- Se já existir um botão com o mesmo Radius, reaproveitaremos o mesmo, para não criar outro.
        dxDrawImage(x, y, width, height, buttons[radius], 0, 0, 0, color, postGUI)
    end
end


function getPositionFromElementOffset(element, offX, offY, offZ) 
    local m = getElementMatrix(element) 
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1] 
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2] 
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3] 
    return x, y, z 
end 

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

local color_animation = {}

function colorAnimation(id, duration, r2, g2, b2, alpha)
    if not color_animation[id] then
        color_animation[id] = {id = id, duration = duration, alpha = alpha, r = r2, g = g2, b = b2, lastR = r2, lastG = g2, lastB = b2, lastA = alpha, tick = nil}
    end
    if r2 ~= color_animation[id].lastR or g2 ~= color_animation[id].lastG or b2 ~= color_animation[id].lastB or alpha ~= color_animation[id].lastA then
        color_animation[id].tick = getTickCount()
        color_animation[id].lastR = r2
        color_animation[id].lastG = g2
        color_animation[id].lastB = b2
        color_animation[id].lastA = alpha
    elseif color_animation[id].r == r2 and color_animation[id].g == g2 and color_animation[id].b == b2 and color_animation[id].alpha == alpha then
        color_animation[id].tick = nil
    end
    if color_animation[id].tick then
        local interpolate = {interpolateBetween(color_animation[id].r, color_animation[id].g, color_animation[id].b, r2, g2, b2, (getTickCount() - color_animation[id].tick) / color_animation[id].duration, 'Linear')}
        local interpolateAlpha = interpolateBetween(color_animation[id].alpha, 0, 0, alpha, 0, 0, (getTickCount() - color_animation[id].tick) / color_animation[id].duration, 'Linear')

        color_animation[id].r = interpolate[1]
        color_animation[id].g = interpolate[2]
        color_animation[id].b = interpolate[3]
        color_animation[id].alpha = interpolateAlpha
    end
    return tocolor(color_animation[id].r, color_animation[id].g, color_animation[id].b, color_animation[id].alpha)
end

function isMouseInPosition ( x, y, width, height )
    if ( not isCursorShowing( ) ) then
        return false
    end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )

    local x, y, width, height = aToR(x, y, width, height)
    
    return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

--local sW, sH = guiGetScreenSize()
--resX, resY = 1920, 1080

