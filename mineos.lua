ФОНА
    drawInfo(xBar, yBar + 1, lang.downloading .. " " .. thingsToDownload[app]["name"])
    local percent = app / #thingsToDownload * 100
    ecs.progressBar(xBar, yBar, barWidth, 1, 0xcccccc, ecs.colors.blue, percent)
 
    ecs.getOSApplication(thingsToDownload[app])
  end
 
  os.sleep(timing)
end
 
--Создаем базовые обои рабочего стола
if downloadWallpapers then
  ecs.createShortCut(desktopPath .. "Pictures.lnk", picturesPath)
  ecs.createShortCut("MineOS/System/OS/Wallpaper.lnk", picturesPath .. "Raspberry.pic")
end
 
--Автозагрузка
local file = io.open("autorun.lua", "w")
file:write("local success, reason = pcall(loadfile(\"OS.lua\")); if not success then print(\"Ошибка: \" .. tostring(reason)) end")
file:close()
 
--------------------------СТАДИЯ ПЕРЕЗАГРУЗКИ КОМПА-----------------------------------
 
ecs.blankWindow(xWindow,yWindow,windowWidth,windowHeight)
 
image.draw(math.floor(xSize/2 - 16), math.floor(ySize/2 - 11), imageOK)
 
--Текстик по центру
gpu.setBackground(ecs.windowColors.background)
gpu.setForeground(ecs.colors.gray)
ecs.centerText("x",yWindowEnd - 5, lang.needToRestart)
 
--Кнопа
drawButton(lang.restart, false)
waitForClickOnButton(lang.restart)
ecs.prepareToExit()
 
computer.shutdown(true)
