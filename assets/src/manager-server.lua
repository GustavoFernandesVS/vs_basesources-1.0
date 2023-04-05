--[[addEventHandler('onResourceStart', resourceRoot, function()
    if (hasObjectPermissionTo(getThisResource(), 'function.startResource', true)) then
        if (getResourceFromName('labz_hudsystem')) then
            if (getResourceState(getResourceFromName('labz_hudsystem')) == 'loaded') then
                startResource(getResourceFromName('labz_hudsystem'))
                
                outputDebugString('[ Labz ] Resources O resource \'labz_hudsystem\' foi iniciado.', 4, 31, 139, 76)
            elseif (getResourceState(getResourceFromName('labz_hudsystem')) ~= 'running') then
                outputDebugString('[ Labz ] Resources O resource \'labz_hudsystem\' não está corretamente inserido, por favor arrume o mesmo.', 4, 31, 139, 76)

                cancelEvent()
            end
        else
            outputDebugString('[ Labz ] Resources O resource \'labz_hudsystem\' não está no servidor, por favor coloque-o.', 4, 31, 139, 76)

            cancelEvent()
        end

        if (getResourceState(getResourceFromName('labz_hudsystem')) == 'running') then
            outputDebugString('[ Labz ] Resources O resource \''..getResourceName(getThisResource())..'\' foi iniciado sem erros.', 4, 31, 139, 76)
        end
    else
        outputDebugString('[ Labz ] Resources O resource \''..getResourceName(getThisResource())..'\' está sem permissão.', 4, 31, 139, 76)

        cancelEvent()
    end
end)--]]