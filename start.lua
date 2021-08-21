serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
print([[

                                                       
                                                       
  ____               ____            ________          
 6MMMMb\            6MMMMb/          `MMMMMMMb.        
6M'    `           8P    YM           MM    `Mb        
MM      ___   ___ 6M      Y    ___    MM     MM        
YM.     `MM    MM MM         6MMMMb   MM     MM        
 YMMMMb  MM    MM MM        8M'  `Mb  MM    .M9        
     `Mb MM    MM MM     ___    ,oMM  MMMMMMM9'        
      MM MM    MM MM     `M',6MM9'MM  MM  \M\          
      MM MM    MM YM      M MM'   MM  MM   \M\         
L    ,M9 YM.   MM  8b    d9 MM.  ,MM  MM    \M\        
MYMMMM9   YMMM9MM_  YMMMM9  `YMMM9'Yb_MM_    \M\_      
                                                       
                                                       
                                                       


      
]])
Server_SuGaR = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_SuGaR = function() 
local Create_Info = function(Token,Sudo,UserName)  
local SuGaR_Info_Sudo = io.open("sudo.lua", 'w')
SuGaR_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
SuGaR_Info_Sudo:close()
end  
if not database:get(Server_SuGaR.."Token_SuGaR") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_SuGaR.."Token_SuGaR",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_SuGaR.."UserName_SuGaR") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://tshake.ml/info/?user="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua start.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua start.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_SuGaR.."UserName_SuGaR",Json.Info.Username)
database:set(Server_SuGaR.."Id_SuGaR",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_SuGaR_Info()
Create_Info(database:get(Server_SuGaR.."Token_SuGaR"),database:get(Server_SuGaR.."Id_SuGaR"),database:get(Server_SuGaR.."UserName_SuGaR"))   
local RunSuGaR = io.open("SuGaR", 'w')
RunSuGaR:write([[
#!/usr/bin/env bash
cd $HOME/SuGaR
token="]]..database:get(Server_SuGaR.."Token_SuGaR")..[["
rm -fr SuGaR.lua
wget "https://raw.githubusercontent.com/Paiqer/SuGaR/master/SuGaR.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./SuGaR.lua -p PROFILE --bot=$token
done
]])
RunSuGaR:close()
local RunTs = io.open("ts", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/SuGaR
while(true) do
rm -fr ../.telegram-cli
screen -S SuGaR -X kill
screen -S SuGaR ./SuGaR
done
]])
RunTs:close()
end
Files_SuGaR_Info()
database:del(Server_SuGaR.."Token_SuGaR");database:del(Server_SuGaR.."Id_SuGaR");database:del(Server_SuGaR.."UserName_SuGaR")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_SuGaR()  
var = true
else   
f:close()  
database:del(Server_SuGaR.."Token_SuGaR");database:del(Server_SuGaR.."Id_SuGaR");database:del(Server_SuGaR.."UserName_SuGaR")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
