


function dl_cb(a,d)  end

function GetInputFile(file)
local file = file or "" 
if file:match('/') then
infile = {ID= "InputFileLocal", path_  = file}
elseif file:match('^%d+$') then
infile = {ID= "InputFileId", id_ = file}
else
infile = {ID= "InputFilePersistentId", persistent_id_ = file}
end
return infile
end

local clock = os.clock
function sleep(time)  
local untime = clock()
while clock() - untime <= time do end
end

function sendMsg(chat_id,reply_id,text,funcb)
tdcli_function({
ID="SendMessage",
chat_id_=chat_id,
reply_to_message_id_= reply_id,
disable_notification_=1,
from_background_= 1,
reply_markup_= nil,
input_message_content_={
ID = "InputMessageText",
text_= text,
disable_web_page_preview_= 1,
clear_draft_= 0,
entities_={},
parse_mode_=  {ID = "TextParseModeMarkdown"} ,
}},funcb or dl_cb,nil)
end

function sendMs(chat_id,reply_id,text,funcb)
tdcli_function({
ID="SendMessage",
chat_id_=chat_id,
reply_to_message_id_= reply_id,
disable_notification_=1,
from_background_= 1,
reply_markup_= nil,
input_message_content_={
ID = "InputMessageText",
text_= text,
disable_web_page_preview_= 1,
clear_draft_= 0,
entities_={},
}},funcb or dl_cb,nil)
end

function sendm(chat_id,reply_id,text,funcb)
tdcli_function({
ID="SendMessage",
chat_id_=chat_id,
reply_to_message_id_= reply_id,
disable_notification_=1,
from_background_= 1,
reply_markup_= nil,
input_message_content_={
ID = "InputMessageText",
text_= text,
disable_web_page_preview_= 0,
clear_draft_= 0,
entities_={},
parse_mode_=  {ID = "TextParseModeMarkdown"} ,
}},funcb or dl_cb,nil)
end


function sendPhoto(chat_id,reply_id,photo,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessagePhoto",
photo_ = GetInputFile(photo),
added_sticker_file_ids_ = {},
width_ = 0,
height_ = 0,
caption_ = caption or ''
}
},func or dl_cb,nil)
end


function sendVoice(chat_id,reply_id,voice,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVoice",
voice_ = GetInputFile(voice),
duration_ = '',
waveform_ = '',
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendAnimation(chat_id,reply_id,animation,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAnimation",
animation_ = GetInputFile(animation),
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendAudio(chat_id,reply_id,audio,title,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = '',
title_ = title or '',
performer_ = '',
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendSticker(chat_id,reply_id,sticker,func)
tdcli_function({
ID='SendMessage',
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageSticker",
sticker_ = GetInputFile(sticker),
width_ = 0,
height_ = 0
}},func or dl_cb,nil)
end

function sendVideo(chat_id,reply_id,video,caption,func)
tdcli_function({ 
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 0,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVideo",  
video_ = GetInputFile(video),
added_sticker_file_ids_ = {},
duration_ = 0,
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil)
end


function sendDocument(chat_id,reply_id,document,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageDocument",
document_ = GetInputFile(document),
caption_ = caption
}},func or dl_cb,nil)
end


function fwdMsg(chat_id,from_chat_id,msg_id,func)
tdcli_function({
ID="ForwardMessages",
chat_id_ = chat_id,
from_chat_id_ = from_chat_id,
message_ids_ = {[0] = msg_id},
disable_notification_ = 0,
from_background_ = 0
},func or dl_cb,nil)
end


function SendMention(chat_id,user_id,msg_id,Text,offset, length) 
tdcli_function ({ 
ID = "SendMessage", 
chat_id_ = chat_id, 
reply_to_message_id_ = msg_id, 
disable_notification_ = 0, 
from_background_ = 1, 
reply_markup_ = nil, 
input_message_content_ = { 
ID = "InputMessageText", 
text_ = Text,
disable_web_page_preview_ = 1, 
clear_draft_ = 0, 
parse_mode_=  {ID = "TextParseModeMarkdown"} ,
entities_ = {[0]={ 
ID="MessageEntityMentionName", 
offset_ = offset , 
length_ = length , 
user_id_ = user_id },},},
},dl_cb, nil)
end

function sendChatAction(chatid,action,func)
tdcli_function({ID = 'SendChatAction',chat_id_ = chatid,action_ = {ID = "SendMessage"..action.."Action",progress_ = 1},}, func or dl_cb,nil)
end





--================================{{  GetChannelFull  }} ===================================
function download_file(Link,Bath)
local Get_Files, res = https.request(Link)
if res == 200 then
local FileD = io.open(Bath,'w+')
FileD:write(Get_Files)
FileD:close()
end
end
--================================{{  GetChannelFull  }} ===================================

function GetFullChat(GroupID,func,Arg)
tdcli_function({ID="GetChannelFull",channel_id_ = tostring(GroupID):gsub("-100","")},func or dl_cb,Arg or nil)
end

--================================{{  KickUser  }} ===================================

function kick_user(user_id,chat_id,func,Arg)
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusKicked"}},func or dl_cb,Arg or nil)
end

--================================{{  UnBlock  }} ===================================

function StatusLeft(chat_id,user_id,func,Arg)
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusLeft"}},func or dl_cb,Arg or nil)
end
--================================{{  DeleteMsg  }} ===================================

function Del_msg(GroupID,msg_id,func,Arg)
tdcli_function({ID="DeleteMessages",chat_id_=GroupID,message_ids_={[0]=msg_id}},func or dl_cb,Arg or nil)
end


function GetPhotoUser(User,func,Arg)
tdcli_function({ID='GetUserProfilePhotos',user_id_=User,offset_=0,limit_=1},func,Arg or nil)
end

function GetMsgInfo(UID,Msg_id,Cb,Arg)
tdcli_function({ID="GetMessage",chat_id_ = UID,message_id_ = Msg_id},Cb,Arg or nil)
end

function GetUserName(User,Cb,Arg)
tdcli_function({ID="SearchPublicChat",username_ = User},Cb,Arg or nil)
end

function GetUserID(User,Cb,Arg)
tdcli_function({ID="GetUser",user_id_ = User},Cb,Arg or nil)
end

function GroupTitle(GroupID,func,Arg)
tdcli_function({ID="GetChat",chat_id_ = GroupID},func or dl_cb,Arg or nil)
end

function GetChannelAdministrators(GroupID,func,limit,Arg)
tdcli_function({ID="GetChannelMembers",channel_id_= tostring(GroupID):gsub('-100',''),filter_={ID = "ChannelMembersAdministrators"},offset_=0,limit_=limit or 25},func,Arg or nil)
end 

function GetChatMember(GroupID,UserID,func,Arg)
tdcli_function({ID='GetChatMember',chat_id_ = GroupID,user_id_ = UserID},func,Arg or nil)
end 

function GetHistory(GroupID,NumDel,func,Arg)
tdcli_function({ID="GetChatHistory",chat_id_ = GroupID,from_message_id_ = 0,offset_ = 0,limit_ = NumDel},func,Arg or nil)
end
-----------------------{ Start Api Token Bot}-----------------------------
function getr(br)
if br then
return "✓"
else
return "✖️"
end
end

function GetApi(web)
local info, res = https.request(web)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, info);
if success then
if not res.ok then return false end
res = res
else
res = false
end
return res
end


--================================{{  ExportChatInviteLink  }} ===================================

function ExportLink(GroupID)
local GetLin,res = https.request(ApiToken..'/exportChatInviteLink?chat_id='..GroupID)
print(res)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, GetLin)
return (res or "")
end

function Restrict(chat_id,user_id,right)
if right == 1 then
ii = https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=false')
elseif right == 2 then
ii = https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=true&can_send_other_messages=true&can_add_web_page_previews=true')
elseif right == 3 then
ii = https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=false&can_send_other_messages=false&can_add_web_page_previews=false')
end
print(ii)
return ii
end


function ChangeNikname(chat_id,user_id,nikname)
--setChatAdministratorCustomTitle
slaheat = user_id
slaheat = slaheat.."&custom_title="..URL.escape(nikname)
result,res = https.request(ApiToken..'/setChatAdministratorCustomTitle?chat_id='..chat_id..'&user_id='..slaheat)
print(result,res)
return result ,res
end


function UploadAdmin(chat_id,user_id,right)

print(chat_id)
print(user_id)
print(right)
slaheat = user_id
if right:match(1) then
slaheat = slaheat.."&can_change_info=true"
end
if right:match(2) then
slaheat = slaheat.."&can_delete_messages=true"
end
if right:match(3) then
slaheat = slaheat.."&can_invite_users=true"
end
if right:match(4) then
slaheat = slaheat.."&can_restrict_members=true"
end
if right:match(5) then
slaheat = slaheat.."&can_pin_messages=true"
end
if right:match(6) then
slaheat = slaheat.."&can_promote_members=true"
end
if right:match("[*][*]") then
slaheat = slaheat.."&can_change_info=true&can_delete_messages=true&can_invite_users=true&can_pin_messages=true&can_restrict_members=true&can_promote_members=true"
elseif right:match("[*]") then
slaheat = slaheat.."&can_change_info=true&can_delete_messages=true&can_invite_users=true&can_pin_messages=true&can_restrict_members=true"
end
print(slaheat)

result,res = https.request(ApiToken..'/promoteChatMember?chat_id='..chat_id..'&user_id='..slaheat)
print(result,res)
return result ,res
end


function send_msg(chat_id,text,msg_id)
local url = ApiToken..'/sendMessage?chat_id='..chat_id..'&text='..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true"
if msg_id then
url = url.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(url)
end

function EditMsg(chat_id,message_id,text,funcb)
local url = ApiToken..'/editMessageText?chat_id='..chat_id ..'&message_id='..tonumber(message_id/2097152/0.5)..'&text='..URL.escape(text)..'&parse_mode=Markdown&disable_web_page_preview=true'
return GetApi(url)
end

function send_key(chat_id,text,keyboard,inline,msg_id)
local response = {}
response.inline_keyboard = inline
response.keyboard = keyboard
response.resize_keyboard = true
response.one_time_keyboard = false
local Send_api = ApiToken.."/sendMessage?chat_id="..chat_id.."&text="..
URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response))
if msg_id then 
Send_api = Send_api.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(Send_api)
end 
function send_keyPhoto(chat_id,text,keyboard,inline,msg_id)
local response = {}
response.inline_keyboard = inline
response.keyboard = keyboard
photo = redis:get(boss..':WELCOME_BOT')
response.resize_keyboard = true
response.one_time_keyboard = false
local Send_api = ApiToken.."/sendPhoto?chat_id="..chat_id.."&photo="..photo.."&caption="..
URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response))
if msg_id then 
Send_api = Send_api.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(Send_api)
end 

function send_inline(chat_id,text,inline,msg_id)
local response = {}
response.inline_keyboard = inline
local Send_api = ApiToken.."/sendMessage?chat_id="..chat_id.."&text="..
URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response))
if msg_id then 
Send_api = Send_api.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(Send_api)
end 


function answerCallbackQuery(callback_query_id, text, show_alert)
local url = ApiToken..'/answerCallbackQuery?callback_query_id='..callback_query_id..'&text='..URL.escape(text)
if show_alert then url = url..'&show_alert=true' end
return GetApi(url)
end


function GetFilePath(FileID)
local UrlInfo = https.request(ApiToken..'/getfile?file_id='..FileID)
return ApiToken..'/'..JSON.decode(UrlInfo).result.file_path
end 

----------------------{ End Api Token Bot }-----------------------------

--[[function UpdateSource(msg,edit)
if edit then EditMsg(msg.chat_id_,msg.id_,'10% - |█          |') end
if edit then EditMsg(msg.chat_id_,msg.id_,'20% - |███         |') end
--download_file('https://raw.githubusercontent.com/SLOM2539/BOSS/master/inc/Run.lua','./inc/Run.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'40% - |█████       |') end
--download_file('https://raw.githubusercontent.com/SLOM2539/BOSS/master/inc/locks.lua','./inc/locks.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'60% - |███████     |') end
--download_file('https://raw.githubusercontent.com/SLOM2539/BOSS/master/inc/Script.lua','./inc/Script.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'80% - |█████████   |') end
--download_file('https://raw.githubusercontent.com/SLOM2539/BOSS/master/inc/functions.lua','./inc/functions.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'100% - |█████████████|\n\n🔝*¦* تم تحديث السورس الى اصدار *v'..redis:get(boss..":VERSION")..'*\n📟*¦* تم اعاده تشغيل السورس بنجاح') end
--if edit then dofile("./inc/Run.lua") end
--print("Update Source And Reload ~ ./inc/Run.lua")

end
--]]
----------------------{ Get Name Bot }-----------------------------
Bot_Name = redis:get(boss..":NameBot:") or "فواز"


function GetType(ChatID) 
if tostring(ChatID):match('^-100') then
return 'channel' 
elseif tostring(ChatID):match('-') then
return 'chat' 
else 
return 'pv'
end 
end

function All_File()
local Text = "🗂| قائمه الملفات : \nـ------------------------------------\n\n"
local Num = 0
local allfiles = io.popen('ls plugins'):lines()
for Files in allfiles do
if Files:match(".lua$") then
Num = Num +1
Text = Text..Num..'- * '..Files..' * \n' 
end
end 
if Num == 0 then
Text = Text.."⇜ Not files ~⪼ مافيه ملفات !"
end 
return Text.."\n\n⇜ لتحميل المزيد من الملفات ادخلل لمتجر الملفات بالامر الاتي {` متجر الملفات `}"
end


function ResolveName(data)
if type(data) == 'table' then
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ else Name = data.first_name_ end
TNAME = FlterName(Name,20) 
else
TNAME = FlterName(data,20)
end
print("| Number char : "..utf8.len(TNAME))
ncn = {}
for c in TNAME:gmatch("[^%s]+") do 
table.insert(ncn,c)  
print(c) 
end
return utf8.escape(ncn[1])
end

function ResolveUserName(data)
if data.username_ then 
USERNAME = '@'..data.username_
else 
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ else Name = data.first_name_ end
USERNAME = FlterName(Name,20) 
end
return USERNAME
end

function Hyper_Link_Name(data)
if data.first_name_ then 
if data.last_name_ then 
Name = data.first_name_ .." "..data.last_name_
else 
Name = data.first_name_ 
end
usernn = data.username_ or "W8gBot"
else 
Name = data.title_
usernn = data.type_.user_.username_ or "W8gBot"
end
Name = Name:gsub('[[][]]','')
Name = FlterName(Name,10)
Name = "["..Name.."](t.me/"..usernn..")"
print(Name)
return Name
end



function Flter_Markdown(TextMsg) 
local Text = tostring(TextMsg)
Text = Text:gsub('_',[[\_]])
Text = Text:gsub('*','\\*')
Text = Text:gsub('`','\\`')
local Hyperlink = Text:match('[(](.*)[)]')
local Hyperlink1 = Text:match('[[](.*)[]]')
if Hyperlink and Hyperlink1 then
Hyperlink = "("..Hyperlink:gsub([[\_]],'_')..")"
Text = Text:gsub('[(](.*)[)]',Hyperlink ) 
Hyperlink1 = Hyperlink1:gsub([[\_]],'_')
Hyperlink1 = "["..Hyperlink1:gsub('[[][]]','').."]"
Text = Text:gsub('[[](.*)[]]',Hyperlink1 ) 
end
return Text 
end



function FlterName(Name,Num)
if Name.last_name_ then
Name = Name.first_name_ .." "..Name.last_name_ 
elseif Name.first_name_ then
Name = Name.first_name_ 
end
return Name
end

--[[
function KlmatMmno3(text)
resq = false
local listFshars = redis:get("UpdatWordsFshar")
if not listFshars then
local Fshar_Word , res = https.request('https://api.th3boss.com/Words_Fshars.txt')
if res ~= 200 then Fshar_Word = "\n" end
redis:setex("UpdatWordsFshar",3600,Fshar_Word)
print(Fshar_Word)
end


for lines in listFshars:gmatch('[^\r\n]+') do
if text:match('^('..lines..')$') or text:match(lines..' .*') or text:match('.* '..lines) then
print("Word is Fshar")
resq = true
end end
print(resq)
return resq
end
]]


function KlmatMmno3(text)
return false
end


function Get_Ttl(msgs)
local MsgShow = '' 
local NumMsg = tonumber(msgs)
if NumMsg < 80 then 
MsgShow = 'ماش' 
elseif NumMsg < 300 then
MsgShow = 'شد حيلك شوي' 
elseif NumMsg < 900 then 
MsgShow = 'مشي حالك' 
elseif NumMsg < 5000 then 
MsgShow = 'يجي منك' 
elseif NumMsg < 9000 then 
MsgShow = 'قوي' 
elseif NumMsg < 10000 then 
MsgShow = 'ابووي يالقوه' 
elseif NumMsg < 100000 then 
MsgShow = 'كنق التيلي' 
elseif NumMsg > 150000 then 
MsgShow = 'تاج راس التيلي' 
end
return MsgShow 
end

function Getrtba(UserID,ChatID)
if UserID == our_id then 
var = 'هذا البوت! ' 
elseif UserID == 1619524486 or UserID == 1619524486  then 
var = '*( مطور السورس )*'
elseif  UserID == SUDO_ID then
var = redis:get(boss..":RtbaNew1:"..ChatID) or '*( Master )*' 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then
var = redis:get(boss..":RtbaNew2:"..ChatID) or '*( Dev )*' 
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then
var = redis:get(boss..":RtbaNew3:"..ChatID) or ' *( المالك الاساسي )*' 
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then
var = redis:get(boss..":RtbaNew4:"..ChatID) or ' *( المالك )*' 
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then
var = redis:get(boss..":RtbaNew5:"..ChatID) or '*( مدير )*' 
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then
var = redis:get(boss..":RtbaNew6:"..ChatID) or '*( ادمن )*' 
elseif redis:sismember(boss..'whitelist:'..ChatID,UserID) then
var = '*( عضو مميز )*' 
if redis:get(boss..":RtbaNew7:"..ChatID) ~= nil then var = '*( '..redis:get(boss..":RtbaNew7:"..ChatID)..' )*' end
else
var = '*( عضو )*' 
end
return var
end

function convert_Klmat(msg,data,Replay,MD)
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local points = redis:get(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_) or 0
local NameUser = ResolveName(data)
local Emsgs = redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
if data.username_ then UserNameID = "@"..data.username_ else UserNameID = "مافيه" end  
if Replay then
Replay = Replay:gsub("{الاسم}",NameUser)
Replay = Replay:gsub("{الايدي}",msg.sender_user_id_)
Replay = Replay:gsub("{المعرف}",UserNameID)
Replay = Replay:gsub("{الرتبه}",msg.TheRank)
Replay = Replay:gsub("{التفاعل}",Get_Ttl(Emsgs))
Replay = Replay:gsub("{الرسائل}",Emsgs)
Replay = Replay:gsub("{التعديل}",edited)
Replay = Replay:gsub("{النقاط}",points)
Replay = Replay:gsub("{البوت}",redis:get(boss..':NameBot:'))
Replay = Replay:gsub("{المطور}",SUDO_USER)
else
Replay =""
end
if MD then
return Replay
else
return Replay
end
end


function SaveNumMsg(msg)
if msg.edited then
redis:incr(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.text and not msg.forward_info_ then
redis:incr(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_)
elseif msg.content_.ID == "MessageChatAddMembers" then 
redis:incr(boss..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessagePhoto" then
redis:incr(boss..':photo:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageSticker" then
redis:incr(boss..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageVoice" then
redis:incr(boss..':voice:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageAudio" then
redis:incr(boss..':audio:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageVideo" then
redis:incr(boss..':video:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageAnimation" then
redis:incr(boss..':animation:'..msg.chat_id_..':'..msg.sender_user_id_)
end
end


--================================{{  We Sudoer  }} ===================================

function we_sudo(msg)
if msg.sender_user_id_ == SUDO_ID then
return true 
else
return false
end 
end


--================================{{  List Sudoer  }} ===================================

function TagAll(msg)
message = "قائمة المنشن : \n\n"
local monshaas = redis:smembers(boss..':MONSHA_Group:'..msg.chat_id_)
local monsha = redis:smembers(boss..':MONSHA_BOT:'..msg.chat_id_)
local Owners = redis:smembers(boss..'owners:'..msg.chat_id_)
local Admins = redis:smembers(boss..'admins:'..msg.chat_id_)
local mmez = redis:smembers(boss..'whitelist:'..msg.chat_id_)
if #monshaas==0 and #monsha==0 and #Owners==0 and #Admins==0 and #mmez==0 then return "* مافيه قائمة حاليا \n *" end
i = 1
for k,v in pairs(mmez) do
if not message:match(v) then
local info  = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."- ["..info.username..'] \n'
else
message = message ..i.. '- ['..info.username..'](t.me/W8gbot) \n'
end

i=i+1
end 
end 
for k,v in pairs(Admins) do
if not message:match(v) then
local info  = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."- ["..info.username..'] \n'
else
message = message ..i.. '- ['..info.username..'](t.me/W8gBot) \n'
end
i=i+1
end 
end 
for k,v in pairs(Owners) do
if not message:match(v) then
local info  = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."- ["..info.username..'] \n'
else
message = message ..i.. '- ['..info.username..'](t.me/W8gbot) \n'
end
i=i+1
end 
end
for k,v in pairs(monsha) do
if not message:match(v) then
local info  = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."- ["..info.username..'] \n'
else
message = message ..i.. '- ['..info.username..'](t.me/w8gbot) \n'
end
i=i+1
end 
end 

for k,v in pairs(monshaas) do
if not message:match(v) then
local info  = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."- ["..info.username..'] \n'
else
message = message ..i.. '- ['..info.username..'](t.me/w8gbot) \n'
end
i=i+1
end 
end 
return message
end

function sudolist(msg)
local list = redis:smembers(boss..':SUDO_BOT:')
message = '*- Master : * \n\n``*➣* ['..SUDO_USER..'] ࿈ (' ..SUDO_ID.. ') \n\n*  ⎻⎻⎻ ── ━━ ⨳ ━━ ── ⎻⎻⎻  *  \n *- Dev :* \n\n '
if #list==0 then  message = message.."* مافيه مطورين حاليا \n *"
else
for k,v in pairs(list) do
local info  = redis:hgetall(boss..'username:'..v)
local count = redis:scard(boss..'mtwr_count'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.." ➣ ["..info.username..'] ࿓ (`' ..v.. '`) \n'
else
message = message ..k.. ' ➣ ['..info.username..'](t.me/w8gbot) ࿓ (`' ..v.. '`) \n'
end
end 
end
if utf8.len(message) > 4096 then
return "⇜ مايمدي اعرض الردود لان القائمة كبيره مره ."
else
return message
end
end

--================================{{  List Constructor  }} ===================================
function conslist(msg)



message = '*- المالكيين الاساسيين:*\n\n'
local monsha = redis:smembers(boss..':MONSHA_Group:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه مالكيين اساسيين !\n"
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.." ➣ ["..info.username..'] ࿈ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ ['..info.username..'](t.me/W8gbot) ࿓  (`' ..v.. '`) \n'
end
end
end

message = message..'\n\n*- المالكيين:*\n\n'
local monsha = redis:smembers(boss..':MONSHA_BOT:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه مالكيين !\n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.." ➣ ["..info.username..'] ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ ['..info.username..'](t.me/W8gbot) ࿓  (`' ..v.. '`) \n'
end
end
end
return message
end
--================================{{  List owner  }} ===================================

function ownerlist(msg)
message = '*- المدراء:*\n\n'
local list = redis:smembers(boss..'owners:'..msg.chat_id_)
if #list == 0 then  
message = message.."مافيه مدراء!\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ ['..(Flter_Markdown(info.username) or '')..'] ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ ['..info.username..'](t.me/W8gbot) ࿓  ( `' ..v.. '` ) \n'
end
end
end
if utf8.len(message) > 4096 then
return "⇜ مايمدي اعرض المدراء لان القائمة كبيره مره "
else
return message
end
end

--================================{{ List Admins  }} ===================================

function GetListAdmin(msg)
local list = redis:smembers(boss..'admins:'..msg.chat_id_)
if #list==0 then  return  "** مافيه ادمنيه! \n" end
message = '*  - الادمن:*\n\n'
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ ['..info.username..'] ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ ['..info.username..'](t.me/W8gbot) ࿓  ( `' ..v.. '` ) \n'
end
end
if utf8.len(message) > 4096 then
return "⇜ مايمدي اعرض الادمنيه لان القائمة كبيره مره."
else
return message
end
end

--================================{{  List WhiteList  }} ===================================

function whitelist(msg)
local list = redis:smembers(boss..'whitelist:'..msg.chat_id_)
if #list == 0 then return "* مافيه مميزين! *" end
message = '* - المميزين:*\n\n'   
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ ['..info.username..'] ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ ['..info.username..'](t.me/W8gbot) ࿓  ( `' ..v.. '` ) \n'
end
end
if utf8.len(message) > 4096 then
return "⇜ مايمدي اعرض المميزين لان القائمة كبيره مره."
else
return message
end
end

--================================{{  Mute User And List Mute User   }} ===================================

function MuteUser(Group, User)
if redis:sismember(boss..'is_silent_users:'..Group,User) then 
return true 
else
return false
end 
end


function MuteUser_list(msg)
local list = redis:smembers(boss..'is_silent_users:'..msg.chat_id_)
if #list==0 then return "** مافيه مكتومين! " end
message = '*المكتومين:* \n\n'
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ ['..info.username..'] ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ ['..info.username..'](t.me/W8gbot) ࿓  ( `' ..v.. '` ) \n'
end
end
if utf8.len(message) > 4096 then
return "⇜ مايمدي اعرض المميزين لان القائمة كبيره مره."
else
return message
end
end


--================================{{  Check Banned And List Banned  }} ===================================


function Check_Banned(Group,User)
if redis:sismember(boss..'banned:'..Group,User) then 
return true 
else
return false
end 
end

function GetListBanned(msg)
local list = redis:smembers(boss..'banned:'..msg.chat_id_)
if #list==0 then return "** مافيه محظورين! " end
message = '*المحظورين:* \n\n'
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ ['..info.username..'] ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ ['..info.username..'](t.me/W8gbot) ࿓  ( `' ..v.. '` ) \n'
end 
end 
if utf8.len(message) > 4096 then
return "⇜ مايمدي اعرض المحظورين لان القائمة كبيره مره."
else
return message
end
end



--================================{{  Sudoer  }} ===================================
function GeneralBanned(User)
if redis:sismember(boss..'gban_users',User) then 
return true 
else
return false
end 
end

function GetListGeneralBanned(msg)
local list = redis:smembers(boss..'gban_users')
if #list==0 then return  "*مافيه محظورين عام*" end
message = '*المحظورين عام:*\n\n'
for k,v in pairs(list) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ ['..info.username..'] ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ ['..info.username..'](t.me/W8gbot) ࿓  ( `' ..v.. '` ) \n'
end
end 
if utf8.len(message) > 4096 then
return " مايمدي اعرض المحظورين بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{  Filter Words  }} ===================================

function FilterX(msg,text)
text = tostring(text)
local var = false
if not msg.Admin and not msg.Special then -- للاعضاء فقط  
local list = redis:smembers(boss..':Filter_Word:'..msg.chat_id_)
if #list ~=0 then
for k,word in pairs(list) do
if text:match('^('..word..')$') or text:match(word..' .*') or text:match('.* '..word) then
Del_msg(msg.chat_id_,msg.id_)
print("Word is Del")
var = true
else
var = false
end
end
else
var = false
end 
end 
return var
end


function FilterXList(msg)
local list = redis:smembers(boss..':Filter_Word:'..msg.chat_id_)
if #list == 0 then return "*⇜* قائمة الكلمات الممنوعه فاضيه" end
filterlist = '*- الكلمات الممنوعه:*\n\n'    
for k,v in pairs(list) do
filterlist = filterlist..'* '..k..' *-  ( '..Flter_Markdown(v)..' )\n'
end
if utf8.len(filterlist) > 4096 then
return "⇜ مايمدي اعرض الممنوع لان القائمة كبيره مره."
else
return filterlist
end
end

function AddFilter(msg, word)
if redis:sismember(boss..':Filter_Word:'..msg.chat_id_,word) then 
return  "*⇜* الكلمة *( "..word.." )* ممنوعه من قبل " 
else
redis:sadd(boss..':Filter_Word:'..msg.chat_id_,word) 
return  "*⇜* الكلمة *( "..word.." )* اضفتها الى قائمة المنع "
end
end

function RemFilter(msg, word)
if redis:sismember(boss..':Filter_Word:'..msg.chat_id_,word) then 
redis:srem(boss..':Filter_Word:'..msg.chat_id_,word) 
return  "*⇜* الكلمة *( "..word.." )* تم السماح فيها " 
else
return  "*⇜* الكلمة *( "..word.." )* مسموح فيها من قبل" 
end
end

------------------------------------------

function CheckFlood(User,ChatID)
local NumberFlood = tonumber(redis:get(boss..':Flood_Spam:'..User..':'..ChatID..':msgs') or 0)
if NumberFlood >= 5 then 
result = false
else
redis:setex(boss..':Flood_Spam:'..User..':'..ChatID..':msgs',2,NumberFlood+1)
result = true
end
return result
end


function buck_up_groups(msg)

json_data = '{"BotID": '..boss..',"UserBot": "'..Bot_User..'","Groups" : {'
local All_Groups_ID = redis:smembers(boss..'group:ids')
for key,GroupS in pairs(All_Groups_ID) do
local NameGroup = (redis:get(boss..'group:name'..GroupS) or '')
NameGroup = NameGroup:gsub('"','')
NameGroup = NameGroup:gsub([[\]],'')
if key == 1 then
json_data =  json_data ..'"'..GroupS..'":{"Title":"'..NameGroup..'"'
else
json_data =  json_data..',"'..GroupS..'":{"Title":"'..NameGroup..'"'
end

local admins = redis:smembers(boss..'admins:'..GroupS)
if #admins ~= 0 then
json_data =  json_data..',"Admins" : {'
for key,value in pairs(admins) do
local info = redis:hgetall(boss..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

local creator = redis:smembers(boss..':MONSHA_BOT:'..GroupS)
if #creator ~= 0 then
json_data =  json_data..',"Creator" : {'
for key,value in pairs(creator) do
local info = redis:hgetall(boss..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end 
end
json_data =  json_data..'}'
end

local owner = redis:smembers(boss..'owners:'..GroupS)
if #owner ~= 0 then
json_data =  json_data..',"Owner" : {'
for key,value in pairs(owner) do
local info = redis:hgetall(boss..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

json_data =  json_data.."}"
end

local Save_Data = io.open("./inc/"..Bot_User..".json","w+")
Save_Data:write(json_data..'}}')
Save_Data:close()
sendDocument(msg.chat_id_,msg.id_,"./inc/"..Bot_User..".json","⇜ ملف النسخه الاحتياطيه ...\n⇜ المجموعات  { "..#All_Groups_ID.." }\n⇜ للبوت  "..Bot_User.."\n⇜ التاريخ  "..os.date("%Y/%m/%d").."\n",dl_cb,nil)
end

function chat_list(msg)
local list = redis:smembers(boss..'group:ids')
message = '*⇜* قائمة المجموعات :\n\n'
for k,v in pairs(list) do 
local info = redis:get(boss..'group:name'..v)
if info then 
if utf8.len(info) > 25 then
info = utf8.escape(utf8.gsub(info,0,25))..'...'
end
message = message..k..'ـ '..Flter_Markdown(info).. ' \nــ ⇜⊱ { `' ..v.. '` } ⊰⇜\n\n'
else 
message = message..k.. 'ـ '..' ☜ ⇜⊱ { `' ..v.. '` } ⊰⇜ \n'
end 
end
all_groups = '⇜ قائمة المجموعات :<br><br>'
for k,v in pairs(list) do 
local info = redis:get(boss..'group:name'..v)
if info then
all_groups = all_groups..' '..k..'- <span style="color: #bd2a2a;">'..info.. '</span> <br> ايدي ⇠ (<span style="color:#078883;">' ..v.. '</span>)<br>'
else
all_groups = all_groups..' '..k.. '- '..' ⇠ (<span style="color:#078883;">' ..v.. '</span>) <br>'
end 
end

if utf8.len(message) > 4096 then
sendMsg(msg.chat_id_,1,'*⇜* معليش عندك كثير من المجموعات\n*⇜* برسل لك ملف فيه قائمة المجموعات المفعله انتظر لحظه ...')
file = io.open("./inc/All_Groups.html", "w")
file:write([[
<html dir="rtl">
<head>
<title>قائمه المجموعات 🗣</title>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Harmattan" rel="stylesheet">

</head>
<style>*{font-family: 'Harmattan', sans-serif;font-weight: 600;text-shadow: 1px 1px 16px black;}</style>
<body>
<p style="color:#018bb6;font-size: 17px;font-weight: 600;" aligin="center">قائمه المجموعات 🗣</p>
<hr>
]]..all_groups..[[

</body>
</html>
]])
file:close()
return sendDocument(msg.chat_id_,msg.id_,'./inc/All_Groups.html','👨🏽‍✈️¦ قائمه المجموعات بالكامله ✓ \n🗃¦ يحتوي ('..#list..') مجموعه \n🖥¦افتح الملف في عارض HTML او بالمتصفح',dl_cb,nil)
else 
return sendMsg(msg.chat_id_,1,message) 
end 
end



function rem_data_group(id_group)
redis:del(
boss..'group:add'..id_group,
boss..'lock_link'..id_group, 
boss..'lock_id'..id_group,
boss..'lock_spam'..id_group, 
boss..'lock_webpage'..id_group,
boss..'lock_markdown'..id_group,
boss..'lock_flood'..id_group,
boss..'lock_bots'..id_group,
boss..'mute_forward'..id_group,
boss..'mute_contact'..id_group,
boss..'mute_location'..id_group,
boss..'mute_document'..id_group,
boss..'mute_keyboard'..id_group,
boss..'mute_game'..id_group,
boss..'mute_inline'..id_group,
boss..'lock_username'..id_group,
boss..'num_msg_max'..id_group,
boss..'mute_text'..id_group,
boss..'admins:'..id_group,
boss..':Filter_Word:'..id_group,
boss..'banned:'..id_group,
boss..'is_silent_users:'..id_group,
boss..'whitelist:'..id_group,
boss..':MONSHA_BOT:'..id_group,
boss..'owners:'..id_group,
boss..'replay'..id_group,
boss..':MONSHA_Group:'..id_group
)
redis:srem(boss..'group:ids',id_group)
end



function set_admins(msg) 
GetChannelAdministrators(msg.chat_id_,function(arg,data)
local NumAdmin = 0
for k,v in pairs(data.members_) do
if not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
NumAdmin = NumAdmin + 1
if not redis:sismember(boss..'admins:'..arg.chat_id_,v.user_id_) then
GetUserID(v.user_id_,function(arg,data)
redis:hset(boss..'username:'..data.id_,'username',ResolveUserName(data))
redis:sadd(boss..'admins:'..arg.chat_id_,data.id_)
end,{chat_id_=msg.chat_id_,id_=msg.id_})
end
end
end
if NumAdmin == 0 then 
return sendMsg(arg.chat_id_,arg.id_,"⇜ مافيه ادمنيه عشان ارفعهم \n")
else
return sendMsg(arg.chat_id_,arg.id_,"⇜ تم رفعت  ( *"..NumAdmin.."* ) مـن الادمنيه‌‏ في البوت \n ")
end
end,30,{chat_id_=msg.chat_id_,id_=msg.id_})
end




function modadd(msg)
if redis:get(boss..'lock_service') then
lock_servicez = true
else
lock_servicez = false
end
if not msg.SudoUser and not lock_servicez then return '⇜ انت مو المطور' end
if msg.is_post_ then return "⇜ معليش هذا بوت حماية للمجموعات مو للقنوات  " end
if msg.type ~= "channel" then return '⇜ البوت يتفعل بس في المجموعات العامه عشان كذا لازم تحط معرف للمجموعة و تخليها عامه  ' end


GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg 
local NameUser   = Hyper_Link_Name(data)
if redis:get(boss..'group:add'..msg.chat_id_) then  return sendMsg(msg.chat_id_,msg.id_,'⇜ المجموعة مفعله من قبل يالطيب!') end
local UserChaneel = redis:get(boss..":UserNameChaneel")
if UserChaneel and not msg.SudoBase then
local url , res = https.request(ApiToken..'/getchatmember?chat_id='..UserChaneel..'&user_id='..msg.sender_user_id_)
if res == 200 then
print(url) 
local Req = JSON.decode(url)
if Req.ok and Req.result and Req.result.status == "left" or Req.result.status == "kicked" then
return sendMsg(msg.chat_id_,msg.id_,"⇜ اشترك بالقناة اول ["..UserChaneel.."] \n⇜ ثم ارجع ارسل تفعيل .")
end
else
return "⇜ اشترك بالقناة اول ["..UserChaneel.."] \n⇜ ثم ارجع ارسل تفعيل ."
end
end



if redis:get(boss..'lock_service') then
lock_servicez = true
else
lock_servicez = false
end

GetFullChat(msg.chat_id_,function(arg,data) 
local GroupUsers = tonumber(redis:get(boss..':addnumberusers') or 0)
local Groupcount = tonumber(data.member_count_)
if GroupUsers  >= Groupcount and not arg.SudoBase then
return sendMsg(arg.chat_id_,arg.id_,'*⇜* مايمديني افعل البوت في المجموعة‏ لازم يصير فيها اكثر من *【'..GroupUsers..'】* عضـو 👤')
end
if data.channel_ and data.channel_.status_.ID  == "ChatMemberStatusMember" then
return sendMsg(arg.chat_id_,arg.id_,'*⇜* انا مو ادمن في المجموعة \n*⇜* ارفعني ادمن عشان تقدر تفعلني \n ')
end
if arg.lock_servicez then 
sendMsg(arg.chat_id_,arg.id_,'⇜ من「 '..NameUser..'」فعلت المجموعة \n⇜ ورفعت كل الادمن \nاضغط هنا [/Commands](https://t.me/W8gbot?start=commands) \n')
redis:set(boss.."idphoto"..arg.chat_id_,true)
redis:set(boss..":yt:"..arg.chat_id_,'on')
redis:set(boss..":sound:"..arg.chat_id_,'on')
redis:set(boss..":tts:"..arg.chat_id_,'on')
redis:set(boss..':bio:'..msg.chat_id_,"yes")
redis:set(boss..":trans:"..arg.chat_id_,'on')
else
sendMsg(arg.chat_id_,arg.id_,'⇜ من「 '..NameUser..'」 \n ابشر فعلت المجموعة\nاضغط هنا [/Commands](https://t.me/W8gBot?start=commands) \n ')
redis:set(boss.."idphoto"..arg.chat_id_,true)
redis:set(boss..":yt:"..arg.chat_id_,'on')
redis:set(boss..":sound:"..arg.chat_id_,'on')
redis:set(boss..":tts:"..arg.chat_id_,'on')
redis:set(boss..":trans:"..arg.chat_id_,'on')
redis:set(boss..':bio:'..msg.chat_id_,"yes")
end

GetChannelAdministrators(arg.chat_id_,function(arg,data)
for k,v in pairs(data.members_) do
if data.members_[k].status_.ID == "ChatMemberStatusCreator" then
GetUserID(v.user_id_,function(arg,data)
redis:hset(boss..'username:'..data.id_,'username', ResolveUserName(data))
redis:sadd(boss..':MONSHA_Group:'..arg.chat_id_,data.id_)
end,{chat_id_=arg.chat_id_})
elseif arg.lock_servicez and not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
if not redis:sismember(boss..'admins:'..arg.chat_id_,v.user_id_) then
GetUserID(v.user_id_,function(arg,data)
redis:hset(boss..'username:'..data.id_,'username',ResolveUserName(data))
redis:sadd(boss..'admins:'..arg.chat_id_,data.id_)
end,{chat_id_=arg.chat_id_})
end
end
end
end,25,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,lock_servicez=arg.lock_servicez})



GroupTitle(arg.chat_id_,function(arg,data)

redis:mset(
boss..'group:add'..arg.chat_id_,true,
boss..'lock_link'..arg.chat_id_,true,
boss..'lock_id'..arg.chat_id_,true,
boss..'mute_keyboard'..arg.chat_id_,true,
boss..'num_msg_max'..arg.chat_id_,5,
boss..'replay'..arg.chat_id_,true,
boss..'lock_rdodSource'..arg.chat_id_,true,
boss..'lock_KickBan'..arg.chat_id_,true,
boss..'lock_KickBan'..arg.chat_id_,true,
boss..'lock_flood'..arg.chat_id_,true,
boss.."lock_RandomRdod"..msg.chat_id_,true,
boss..'lock_linkk'..arg.chat_id_,true
)
redis:del(
boss..'lock_edit'..arg.chat_id_,
boss..'lock_link'..arg.chat_id_,
boss..'lock_tag'..arg.chat_id_,
boss..'lock_username'..arg.chat_id_,
boss..'lock_spam'..arg.chat_id_,
boss..'lock_webpage'..arg.chat_id_,
boss..'lock_markdown'..arg.chat_id_,
boss..'lock_bots_by_kick'..arg.chat_id_,
boss..'lock_bots'..arg.chat_id_,
boss..'mute_gif'..arg.chat_id_,
boss..'mute_text'..arg.chat_id_,
boss..'mute_inline'..arg.chat_id_,
boss..'mute_game'..arg.chat_id_,
boss..'mute_photo'..arg.chat_id_,
boss..'mute_video'..arg.chat_id_,
boss..'mute_audio'..arg.chat_id_,
boss..'mute_voice'..arg.chat_id_,
boss..'mute_sticker'..arg.chat_id_,
boss..'mute_contact'..arg.chat_id_,
boss..'mute_forward'..arg.chat_id_,
boss..'mute_location'..arg.chat_id_,
boss..'mute_document'..arg.chat_id_,
boss..'mute_tgservice'..arg.chat_id_,
boss..'lock_mmno3'..arg.chat_id_,
boss..'lock_pharsi'..arg.chat_id_,
boss..'lock_lang'..arg.chat_id_
)
redis:sadd(boss..'group:ids',arg.chat_id_) 
redis:sadd(boss..'mtwr_count'..arg.sender_user_id_,arg.chat_id_)

local NameGroup = data.title_
redis:set(boss..'group:name'..arg.chat_id_,NameGroup)
if not arg.invite_link_ then
Gp_Link = ExportLink(arg.chat_id_)
if Gp_Link and Gp_Link.result then
Gp_Link = Gp_Link.result
else
Gp_Link = ""
end
else
Gp_Link = arg.invite_link_
end
redis:set(boss..'linkGroup'..arg.chat_id_,Gp_Link)
if arg.sender_user_id_ == SUDO_ID then return false end
GetUserID(arg.sender_user_id_,function(arg,datai)
if datai.username_ then 
USERNAME_T = '*⇜* الـمعرف  ⇜⊱ @['..datai.username_..'] ⊰⇜\n'
else 
USERNAME_T = ''
end
send_msg(SUDO_ID,'*⇜* قام شخص بتفعيل البوت ...\n\nــــــــــــــــــــــــــــــــــــــــــ\n⇜ معلومات المجموعه\n'
..'⇜ الاسم ⇜⊱ ['..arg.NameGroup..']('..arg.Gp_Link..') ⊰⇜ \n'
..'⇜ الايدي ⇜⊱`'..arg.chat_id_..'`⊰⇜\n'
..'⇜ ألاعـضـاء ⇜⊱{ *'..arg.Groupcount..'* }⊰⇜ \nــــــــــــــــــــــــــــــــــــــــــ\n⇜ معلومات الشخص \n'
..'*⇜* الاسـم ⇜⊱{ ['..FlterName(datai.first_name_..' '..(datai.last_name_ or ""),23)..'](tg://user?id='..arg.sender_user_id_..') }⊰⇜\n\n'
..USERNAME_T..'⇜ التاريخ ⇜⊱* '..os.date("%Y/%m/%d")
..' *⊰⇜\n⇜ الساعه ⇜⊱* '..os.date("%I:%M%p")..' *⊰⇜')
end,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,NameGroup=NameGroup,Gp_Link=Gp_Link,Groupcount=arg.Groupcount})
end,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,Groupcount=Groupcount,invite_link_=data.invite_link_})


end,{chat_id_=msg.chat_id_,id_=msg.id_,sender_user_id_=msg.sender_user_id_,lock_servicez=lock_servicez})
end,{msg=msg})
return false
end

function action_by_reply(arg,data)  --===  معلومات الرد 
local MsgID = arg.msg.id_
local ChatID = arg.msg.chat_id_
if data.sender_user_id_ then
local cmd = arg.cmd
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)

local Resolv = ResolveUserName(data)
local NameUser = Hyper_Link_Name(data)
if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)


--====================={ start of rf3 }===================

--======={ زق }==========


if cmd == "Z" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':ZZ:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ زق من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':ZZ:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار زق \n ',17,USERCAR) 
end
if cmd == "ZZZ" then
if not redis:sismember(boss..':ZZ:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو زق من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':ZZ:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة الزق \n ',17,USERCAR) 
end


--======={ كيك }==========

if cmd == "k" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':kk:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ كيكه من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':kk:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار كيكه \n ',17,USERCAR) 
end
if cmd == "kkk" then
if not redis:sismember(boss..':kk:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو كيكه من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':kk:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة الكيك \n ',17,USERCAR) 
end



--======={ حمار }==========

if cmd == "h" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':hh:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ حمار من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':hh:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار حمار \n ',17,USERCAR) 
end
if cmd == "hhh" then
if not redis:sismember(boss..':hh:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو حمار من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':hh:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة الحمير \n ',17,USERCAR) 
end


--======={ عسل }==========

if cmd == "q" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':qq:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ عسل من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':qq:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار عسل \n ',17,USERCAR) 
end
if cmd == "qqq" then
if not redis:sismember(boss..':qq:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو عسل من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':qq:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة العسل \n ',17,USERCAR) 
end


--======={ بقره }==========

if cmd == "b" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':bb:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ بقره من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':bb:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار بقره \n ',17,USERCAR) 
end
if cmd == "bbb" then
if not redis:sismember(boss..':bb:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو بقره من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':bb:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة البقر \n ',17,USERCAR) 
end


--======={ كلب }==========


if cmd == "l" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':ll:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ كلب من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':ll:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار كلب \n ',17,USERCAR) 
end
if cmd == "lll" then
if not redis:sismember(boss..':ll:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو كلب من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':ll:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة الكلاب \n ',17,USERCAR) 
end


--======={ قرد }==========

if cmd == "g" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':gg:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ قرد من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':gg:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار قرد \n ',17,USERCAR) 
end
if cmd == "ggg" then
if not redis:sismember(boss..':gg:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو قرد من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':gg:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة القرود \n ',17,USERCAR) 
end


--======={ تيس }==========

if cmd == "t" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':tt:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ تيس من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':tt:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار تيس \n ',17,USERCAR) 
end
if cmd == "ttt" then
if not redis:sismember(boss..':tt:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو تيس من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':tt:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة التيوس \n ',17,USERCAR) 
end


--======={ ثور }==========


if cmd == "f" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':ff:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ ثور من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':ff:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار ثور \n ',17,USERCAR) 
end
if cmd == "fff" then
if not redis:sismember(boss..':ff:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو ثور من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':ff:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة الثيران \n ',17,USERCAR) 
end

--======={ باعوص }==========

if cmd == "c" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':cc:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ باعوص من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':cc:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار باعوص \n ',17,USERCAR) 
end
if cmd == "ccc" then
if not redis:sismember(boss..':cc:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو باعوص من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':cc:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة البواعيص \n ',17,USERCAR) 
end


--======={ الدجاج }==========

if cmd == "d" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':dd:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ دجاجه من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':dd:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار دجاجه \n ',17,USERCAR) 
end
if cmd == "ddd" then
if not redis:sismember(boss..':dd:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو دجاجه من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':dd:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة الدجاج \n ',17,USERCAR) 
end


--======={ هطف }==========

if cmd == "a" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':aa:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ هطف من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':aa:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار هطف \n ',17,USERCAR) 
end
if cmd == "aaa" then
if not redis:sismember(boss..':aa:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو هطف من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':aa:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة الهطوف \n ',17,USERCAR) 
end


--======={ صياد }==========

if cmd == "m" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':mm:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ صياد من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':mm:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار صياد \n ',17,USERCAR) 
end
if cmd == "mmm" then
if not redis:sismember(boss..':mm:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو صياد من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':mm:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة الصيادين \n ',17,USERCAR) 
end


--======={ خاروف }==========


if cmd == "r" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفعني! \n ") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*⇜* مايمديك ترفع بوت! \n ") 
elseif data.type_.ID == "ChannelChatInfo" then 
end
if redis:sismember(boss..':rr:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ خاروف من قبل \n ',17,USERCAR) 
end
redis:sadd(boss..':rr:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ رفعته صار خاروف \n ',17,USERCAR) 
end
if cmd == "rrr" then
if not redis:sismember(boss..':rr:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ مو خاروف من قبل \n ',17,USERCAR) 
end
redis:srem(boss..':rr:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'⇜ العضو 「 '..NameUser..' 」 \n⇜ نزلته من قائمة الخرفان \n ',17,USERCAR) 
end

--====================={ end of rf3 }===================


end) -- سنقر لا تقرب 
end -- سنقر لا تقرب
end -- زوداننن 😂😔





--====================={ start of list }===================



--======={ زق }==========

function ZZZZ(msg) 
local message = '*- قائمة الزق 💩  *\n\n'
local monsha = redis:smembers(boss..':ZZ:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ كيك }==========


function kkkk(msg) 
local message = '*- قائمة الكيك *\n\n'
local monsha = redis:smembers(boss..':kk:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ حمار }==========

function hhhh(msg) 
local message = '*- قائمة الحمير 🦓*\n\n'
local monsha = redis:smembers(boss..':hh:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ عسل }==========

function qqqq(msg) 
local message = '*- قائمة العسل 🍯*\n\n'
local monsha = redis:smembers(boss..':qq:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ بقره }==========

function bbbb(msg) 
local message = '*- قائمة البقر 🐄*\n\n'
local monsha = redis:smembers(boss..':bb:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ كلب }==========


function llll(msg) 
local message = '*- قائمة الكلاب 🐩*\n\n'
local monsha = redis:smembers(boss..':ll:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ قرد }==========

function gggg(msg) 
local message = '*- قائمة القرود *\n\n'
local monsha = redis:smembers(boss..':gg:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ تيس }==========


function tttt(msg) 
local message = '*- قائمة التيوس *\n\n'
local monsha = redis:smembers(boss..':tt:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ ثور }==========

function ffff(msg) 
local message = '*- قائمة الثيران 🐂*\n\n'
local monsha = redis:smembers(boss..':ff:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ باعوص }==========

function cccc(msg) 
local message = '*- قائمة البواعيص 🚼*\n\n'
local monsha = redis:smembers(boss..':cc:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ الدجاج }==========

function dddd(msg) 
local message = '*- قائمة الدجاج 🐔*\n\n'
local monsha = redis:smembers(boss..':dd:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ هطف }==========

function aaaa(msg) 
local message = '*- قائمة الهطوف 🧱*\n\n'
local monsha = redis:smembers(boss..':aa:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ صياد }==========


function mmmm(msg) 
local message = '*- قائمة الصيادين 🔫*\n\n'
local monsha = redis:smembers(boss..':mm:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--======={ خاروف }==========

function rrrr(msg) 
local message = '*- قائمة الخرفان 🐏*\n\n'
local monsha = redis:smembers(boss..':rr:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."⇜ مافيه احد مرفوع \n "
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
else
message = message ..k.. ' ➣ '..(Flter_Markdown(info.username) or '')..' ࿓ ( `' ..v.. '` ) \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end

--====================={ end of list }===================




function action_by_id(arg, data)
local cmd = arg.cmd
local ChatID = arg.msg.chat_id_
local MsgID = arg.msg.id_
local msg = arg.msg or ""
if not data.id_ then 
sendMsg(ChatID,MsgID,"*⇜* العضو لا يوجد\n") 
return false
end
local UserID = data.id_
local Resolv = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)






if cmd == "tqeed" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد البوت! \n") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المطور الاساسي!\n") 
elseif UserID == 1619524486 or UserID == 1619524486 then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد مطور السورس!\n") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المطور!\n") 
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المالك!\n") 
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المالك الاساسي!\n") 
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المدير!\n") 
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد الادمن!\n") 
elseif  redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المميز!\n") 
end
Restrict(ChatID,UserID,1)
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..':tqeed:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ قييدته \n ")
end 
if cmd =="fktqeed" then
Restrict(ChatID,UserID,2)
redis:srem(boss..':tqeed:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ الغيت تقييده \n ")
end
if cmd == "setwhitelist" then
if redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ الحلو「 "..NameUser.." 」 \n⇜ مميز  من قبل \n ") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'whitelist:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ الحلو「 "..NameUser.." 」 \n⇜ رفعته صار مميز  \n ") 
end
if cmd == "remwhitelist" then
if not redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ مو مميز  من قبل \n ") 
end
redis:srem(boss..'whitelist:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ نزلته من المميز  \n ") 
end
if cmd == "setmnsha" then
if redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ مالك من قبل \n ") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..':MONSHA_BOT:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ الحلو「 "..NameUser.." 」 \n⇜ رفعته صار مالك \n ") 
end
if cmd == "remmnsha" then
if not redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID," 「 "..NameUser.." 」 \n⇜ مو مالك من قبل \n ") 
end
redis:srem(boss..':MONSHA_BOT:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ نزلته من المالك \n ") 
end

if cmd == "setowner" then
if redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ الحلو「 "..NameUser.." 」 \n⇜ مدير من قبل \n ") 
end
Resolv = Resolv:gsub([[\_]],"_")
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'owners:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ الحلو「 "..NameUser.." 」 \n⇜ رفعته صار مدير \n ") 
end
if cmd == "remowner" then
if not redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ مو مدير من قبل \n ") 
end
redis:srem(boss..'owners:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ نزلته من المدير \n ") 
end
if cmd == "promote" then
if redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ الحلو「 "..NameUser.." 」 \n⇜ ادمن من قبل \n ") 
end
Resolv = Resolv:gsub([[\_]],"_")
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'admins:'..ChatID,UserID) 
return sendMsg(ChatID,MsgID,"⇜ الحلو「 "..NameUser.." 」 \n⇜ رفعته صار ادمن  \n ") 
end
if cmd == "demote" then
if not redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ مو ادمن من قبل \n ") 
end
redis:srem(boss..'admins:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ نزلته من الادمن \n ") 
end
if cmd == "whois" then
GetChatMember(ChatID,UserID,function(arg,data1)
local namei = data.first_name_..' '..(data.last_name_ or "")
if data.username_ then useri = '@'..data.username_ else useri = " مافيه " end
return SendMention(ChatID,UserID,MsgID,'⇜ الاسم ↢ '..namei..'\n'
..'⇜ الايدي ↢ '..UserID..' \n'
..'⇜ المعرف ↢ '..useri..'\n'
..'⇜ الرتبه ↢ '..Getrtba(UserID,ChatID)..'\n'
..'⇜ نوع الكشف ↢ بالايدي\n ',13,utf8.len(namei))
end)
end

if cmd == "Upmonsh" then
if redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ الحلو「 "..NameUser.." 」 \n⇜ مالك اساسي من قبل \n ") 
end
redis:hset(boss..'username:'..UserID,'username',USERNAME)
redis:sadd(boss..':MONSHA_Group:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ الحلو「 "..NameUser.." 」 \n⇜ رفعته صار مالك اساسي \n ") 
end

if cmd == "Dwmonsh" then
if not redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ مو مالك اساسي من قبل \n ") 
end
redis:srem(boss..':MONSHA_Group:'..ChatID,UserID) 
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ نزلته من المالك الاساسي \n ") 
end

if cmd == "up_sudo" then
if redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"⇜ الحلو「 "..NameUser.." 」 \n⇜ مطور من قبل \n ") 
end
redis:hset(boss..'username:'..UserID, 'username', USERNAME)
redis:sadd(boss..':SUDO_BOT:',UserID)
return sendMsg(ChatID,MsgID,"⇜ الحلو「 "..NameUser.." 」 \n⇜ رفعته صار مطور \n") 
end

if cmd == "dn_sudo" then
if not redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ مو مطور من قبل \n ") 
end
redis:srem(boss..':SUDO_BOT:',UserID) 
return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ نزلته من المطور \n ") 
end

if cmd == "ban" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تحظر البوت! \n") 
elseif UserID == 1619524486 or UserID == 1619524486 then 
return sendMsg(ChatID,MsgID,"️*⇜* هييه مايمديك تحظر مطور السورس! \n") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تحظر المطور الاساسي ياورع! \n") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تحظر المطور! \n") 
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تحظر المالك! \n") 
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تحظر المالك الاساسي! \n") 
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تحظر المدير! \n") 
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تحظر الادمن! \n")
elseif  redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تحظر المميز! \n") 
end
if Check_Banned(ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ محظور من قبل \n ") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'banned:'..ChatID,UserID)
kick_user(UserID, ChatID)
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ حظرته \n ") 
end

if cmd == "kick" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد البوت! \n ") 
elseif UserID == 1619524486 or UserID == 1619524486 then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد مطور السورس!\n ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المطور الاساسي ياورع! \n ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المطور!\n ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المالك!\n ") 
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المالك الاساسي!\n ") 
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المدير!\n ") 
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد الادمن!\n ") 
elseif  redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تطرد المميز!\n ") 
end
kick_user(UserID, ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'*⇜* مايمديني اطرده \n*⇜* لان عنده اشراف \n ')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'*⇜* مايمديني اطرده \n*⇜* ماعندي صلاحية الحظر او مو مشرفه\n ')    
end
StatusLeft(ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ طردته \n ") 
end)
end

if cmd == "uban" then
if not Check_Banned(ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ ملغيه حظره من قبل \n ") 
else
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ الغيت حظره \n ") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:srem(boss..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return false
end

if cmd == "ktm" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تكتم البوت! \n ") 
elseif UserID == 1619524486 or UserID == 1619524486 then 
return sendMsg(ChatID,MsgID,"️*⇜* هييه مايمديك تكتم مطور السورس! \n ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تكتم المطور الاساسي ياورع! \n ") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تكتم المطور! \n ") 
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تكتم المالك! \n ") 
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تكتم المالك الاساسي! \n ") 
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تكتم المدير! \n ") 
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تكتم الادمن!\n ") 
elseif  redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* هييه مايمديك تكتم المميز! \n ") 
end
if redis:sismember(boss..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك تكتم المدراء و الادمنيه! \n") 
end
if MuteUser(ChatID, UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ مكتوم من قبل \n") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ كتمته \n ") 
end

if cmd == "unktm" then
if not MuteUser(ChatID, UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ ملغيه كتمه من قبل \n") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:srem(boss..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ الغيت كتمه \n ") 
end

if cmd == "upMshrf" then
redis:hset(boss..'username:'..UserID,'username',Resolv)
redis:setex(boss..":uploadingsomeon:"..ChatID..msg.sender_user_id_,500,NameUser)
redis:setex(boss..":uploadingsomeon2:"..ChatID..msg.sender_user_id_,500,UserID)
sendMsg(ChatID,MsgID,"⇜ تمام الحين ارسل صلاحيات المشرف \n\n1 ⇜ صلاحيه تغيير المعلومات\n2 ⇜ صلاحيه حذف الرسائل\n3 ⇜ صلاحيه دعوه مستخدمين\n4 ⇜ صلاحيه حظر وتقيد المستخدمين \n5 ⇜ صلاحيه تثبيت الرسائل \n6 ⇜ صلاحيه رفع مشرفين اخرين\n\n[*] ⇜ لرفع كل الصلاحيات ما عدا رفع المشرفين \n[**] ⇜ لرفع كل الصلاحيات مع رفع المشرفين \n\n⇜ يمديك تختار الارقام مع بعض وتعيين لقب للمشرف في سطر واحد  \n\nمثال: 136 الهطف \n ") 
return false
end

if cmd == "DwonMshrf" then
ResAdmin = UploadAdmin(ChatID,UserID,"")  
if ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: CHAT_ADMIN_REQUIRED"}' then return sendMsg(ChatID,MsgID,"*⇜*مايمديني انزله لانه مرفوع من مالك ثاني \n")  end
redis:srem(boss..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(boss..'owners:'..ChatID,UserID)
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
sendMsg(ChatID,MsgID,"「 "..NameUser.." 」 \n⇜ نزلته من مشرفين المجموعة \n ")
return false
end

if cmd == "bandall" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*⇜* مايمديك تحظر البوت\n") 
elseif UserID == 1619524486 or UserID == 1619524486 then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك تحظر مطور السورس\n") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك تحظر المطور الاساسي\n")
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*⇜* مايمديك تحظر المطور\n") 
end
if GeneralBanned(UserID) then 
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ محظور عام من قبل \n ") 
end
redis:hset(boss..'username:'..UserID, 'username', Resolv)
redis:sadd(boss..'gban_users',UserID)
kick_user(UserID,ChatID) 
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ حظرته عام السبيكه \n ") 
end

if cmd == "unbandall" then  
if not GeneralBanned(UserID) then
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ مو محظور عام من قبل \n ") 
end
redis:srem(boss..'gban_users',UserID)
StatusLeft(ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n⇜ الغيت حظره عام \n ") 
end

if cmd == "tfa3l" then  
local maseegs = redis:get(boss..'msgs:'..UserID..':'..ChatID) or 1
local edited = redis:get(boss..':edited:'..ChatID..':'..UserID) or 0
local content = redis:get(boss..':adduser:'..ChatID..':'..UserID) or 0
if data.username_ then UserNameID = "@"..data.username_ else UserNameID = "لا يوجد" end  

sendMsg(ChatID,MsgID,"🎟↧ايديه ↞ `"..UserID.."`\n💬↧رسائله ↞ "..maseegs.."\n🎫↧معرفه ↞ ["..UserNameID.."]\n🧨↧تفاعله ↞ "..Get_Ttl(maseegs).."\n🔫↧رتبته ↞ "..Getrtba(UserID,ChatID).."\n💡️↧تعديلاته ↞ "..edited.."\n📞↧جهاته ↞ "..content.." \n ") 
end

if cmd == "rfaqud" then  
if UserID == our_id then return sendMsg(ChatID,MsgID,"*⇜* مايمديك تسوي الامر وانت ترد على رسالة البوت \n") end
Restrict(ChatID,UserID,2)
redis:srem(boss..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
redis:srem(boss..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"⇜ العضو 「 "..NameUser.." 」 \n  رفعت عنه القيود ان كان فيه\n ") 
end

--========================================================================
if cmd == "DwnAll" then ----------- تنزيل الكل
print(UserID..":"..SUDO_ID)
if UserID == our_id then return sendMsg(ChatID,MsgID,"*⇜* مايمديك تسوي الامر مع البوت\n") end
if UserID == 1619524486 or UserID == 1619524486 then return sendMsg(ChatID,MsgID,"*⇜* مايمديك تنزل مطور السورس  \n") end

if UserID == SUDO_ID then 
rinkuser = 1
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
rinkuser = 2
elseif redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
rinkuser = 3
elseif redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
rinkuser = 4
elseif redis:sismember(boss..'owners:'..ChatID,UserID) then 
rinkuser = 5
elseif redis:sismember(boss..'admins:'..ChatID,UserID) then 
rinkuser = 6
elseif redis:sismember(boss..'whitelist:'..ChatID,UserID) then 
rinkuser = 7
else
rinkuser = 8
end
local DonisDown = "\n⇜ طيرناه من الرتب التاليه : \n\n "
if redis:sismember(boss..':SUDO_BOT:',UserID) then 
DonisDown = DonisDown.."المطور ✘\n"
end 
if redis:sismember(boss..':MONSHA_Group:'..ChatID,UserID) then 
DonisDown = DonisDown.."المالك الاساسي  ✘️\n"
end 
if redis:sismember(boss..':MONSHA_BOT:'..ChatID,UserID) then 
DonisDown = DonisDown.."المالك ✘\n"
end 
if redis:sismember(boss..'owners:'..ChatID,UserID) then 
DonisDown = DonisDown.."المدير ✘\n"
end 
if redis:sismember(boss..'admins:'..ChatID,UserID) then 
DonisDown = DonisDown.."الادمن ✘\n"
end 
if redis:sismember(boss..'whitelist:'..ChatID,UserID) then
DonisDown = DonisDown.."العضو المميز ✘\n"
end

function senddwon()  sendMsg(ChatID,MsgID,"*⇜* رتبته اعلى منك مايمديك تنزله! \n") end
function sendpluse() sendMsg(ChatID,MsgID,"*⇜* رتبته مثلك مايمديك تنزله! : "..msg.TheRankCmd.." \n❕") end

if rinkuser == 8 then return sendMsg(ChatID,MsgID,"「 "..NameUser.." 」   \n⇜ عضو من قبل \n ")  end
huk = false
if msg.SudoBase then 
redis:srem(boss..':SUDO_BOT:',UserID)
redis:srem(boss..':MONSHA_Group:'..ChatID,UserID)
redis:srem(boss..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(boss..'owners:'..ChatID,UserID)
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
elseif msg.SudoUser then 
if rinkuser == 2 then return sendpluse() end
if rinkuser < 2 then return senddwon() end
redis:srem(boss..':MONSHA_Group:'..ChatID,UserID)
redis:srem(boss..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(boss..'owners:'..ChatID,UserID)
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
elseif msg.SuperCreator then 
if rinkuser == 3 then return sendpluse() end
if rinkuser < 3 then return senddwon() end
redis:srem(boss..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(boss..'owners:'..ChatID,UserID)
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
elseif msg.Creator then 
if rinkuser == 4 then return sendpluse() end
if rinkuser < 5 then return senddwon() end
redis:srem(boss..'owners:'..ChatID,UserID)
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
elseif msg.Director then 
if rinkuser == 5 then return sendpluse() end
if rinkuser < 5 then return senddwon() end
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
elseif msg.Admin then 
if rinkuser == 6 then return sendpluse() end
if rinkuser < 6 then return senddwon() end
redis:srem(boss..'admins:'..ChatID,UserID)
redis:srem(boss..'whitelist:'..ChatID,UserID)
else
huk = true
end

if not huk then sendMsg(ChatID,UserID,"「 "..NameUser.." 」 \n"..DonisDown.."\n ") end

end

end

function settingsall(msg)

list_settings = "**` اعدادات المجموعه :` \n"
.."\n⇜ التعديل ⇠ "..(redis:get(boss..'lock_edit'..msg.chat_id_) or 'false')
.."\n⇜ الروابط ⇠ "..(redis:get(boss..'lock_link'..msg.chat_id_) or 'false')
.."\n⇜ الهاشتاق ⇠ "..(redis:get(boss..'lock_tag'..msg.chat_id_) or 'false')
.."\n⇜ المعرفات ⇠ "..(redis:get(boss..'lock_username'..msg.chat_id_) or 'false')
.."\n\n⇜ التكرار ⇠ "..(redis:get(boss..'lock_flood'..msg.chat_id_) or 'false')
.."\n⇜ الكلايش ⇠ "..(redis:get(boss..'lock_spam'..msg.chat_id_) or 'false')
.."\n⇜ الويب ⇠ "..(redis:get(boss..'lock_webpage'..msg.chat_id_) or 'false')
.."\n⇜ الماركدوان ⇠ "..(redis:get(boss..'lock_markdown'..msg.chat_id_) or 'false')
.."\n⇜ البوتات بالطرد ⇠ "..(redis:get(boss..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\n⇜ البوتات ⇠ "..(redis:get(boss..'lock_bots'..msg.chat_id_) or 'false')
.."\n⇜ عدد التكرار ⇠ "..(redis:get(boss..'num_msg_max'..msg.chat_id_) or 'false')
.."\n⇜ وقت التنظيف ⇠ "..(redis:get(boss..':Timer_Cleaner:'..msg.chat_id_) or '6').." ساعة "
.."\n\n` اعدادات الوسائط :`\n"
.."\n*⇜* المتحركه ⇠ "..(redis:get(boss..'mute_gif'..msg.chat_id_) or 'false')
.."\n⇜ الدردشه ⇠ "..(redis:get(boss..'mute_text'..msg.chat_id_) or 'false')
.."\n⇜ الانلاين ⇠ "..(redis:get(boss..'mute_inline'..msg.chat_id_) or 'false')
.."\n⇜ الالعاب ⇠ "..(redis:get(boss..'mute_game'..msg.chat_id_) or 'false')
.."\n⇜ الصور ⇠ "..(redis:get(boss..'mute_photo'..msg.chat_id_) or 'false')
.."\n⇜ الفيديو ⇠ "..(redis:get(boss..'mute_video'..msg.chat_id_) or 'false')
.."\n⇜ الصوت ⇠ "..(redis:get(boss..'mute_audio'..msg.chat_id_) or 'false')
.."\n\n⇜ البصمات ⇠ "..(redis:get(boss..'mute_voice'..msg.chat_id_) or 'false')
.."\n⇜ الملصقات ⇠ "..(redis:get(boss..'mute_sticker'..msg.chat_id_) or 'false')
.."\n⇜ الجهات ⇠ "..(redis:get(boss..'mute_contact'..msg.chat_id_) or 'false')
.."\n⇜ التوجيه ⇠ "..(redis:get(boss..'mute_forward'..msg.chat_id_) or 'false')
.."\n⇜ الموقع ⇠ "..(redis:get(boss..'mute_location'..msg.chat_id_) or 'false')
.."\n⇜ الملفات ⇠ "..(redis:get(boss..'mute_document'..msg.chat_id_) or 'false')
.."\n⇜ الاشعارات ⇠ "..(redis:get(boss..'mute_tgservice'..msg.chat_id_) or 'false')
.."\n⇜ الفشار ⇠ "..(redis:get(boss..'lock_mmno3'..msg.chat_id_) or 'false')
.."\n⇜ الفارسيه ⇠ "..(redis:get(boss..'lock_pharsi'..msg.chat_id_) or 'false')
.."\n⇜ الانجليزية ⇠ "..(redis:get(boss..'lock_lang'..msg.chat_id_) or 'false')
.."\n⇜ الاضافه ⇠ "..(redis:get(boss..'lock_Add'..msg.chat_id_) or 'false')

local eueuf = "\n\n**` اعدادات اخرى :` \n "
.."\n*⇜* الترحيب ⇠ "..(redis:get(boss..'welcome:get'..msg.chat_id_) or 'false')
.."\n*⇜*  الردود ⇠ "..(redis:get(boss..'replay'..msg.chat_id_) or 'false')
.."\n*⇜*  الردود العشوائيه ⇠ "..(redis:get(boss.."lock_RandomRdod"..msg.chat_id_) or 'false')
.."\n*⇜*  التحذير ⇠ "..(redis:get(boss..'lock_woring'..msg.chat_id_) or 'false')
.."\n*⇜* الايدي ⇠ "..(redis:get(boss..'lock_id'..msg.chat_id_) or 'false')
.."\n*⇜* الرابط ⇠ "..(redis:get(boss..'lock_linkk'..msg.chat_id_) or 'false')
.."\n*⇜* المغادره ⇠ "..(redis:get(boss..'lock_leftgroup'..msg.chat_id_) or 'false')
.."\n*⇜* الحظر ⇠ "..(redis:get(boss..'lock_KickBan'..msg.chat_id_) or 'false')
.."\n*⇜* الحمايه ⇠ "..(redis:get(boss..'antiedit'..msg.chat_id_) or 'false')
.."\n*⇜* التاق للكل ⇠ "..(redis:get(boss..'lock_takkl'..msg.chat_id_) or 'false')
.."\n*⇜* الايدي بالصوره ⇠ "..(redis:get(boss..'idphoto'..msg.chat_id_) or 'false')
.."\n*⇜* التحقق ⇠ "..(redis:get(boss.."lock_check"..msg.chat_id_) or 'false')
.."\n*⇜* التنظيف التلقائي ⇠ "..(redis:get(boss.."lock_cleaner"..msg.chat_id_) or 'false')
.."\n*⇜* ردود المطور ⇠ "..(redis:get(boss.."lock_rdodSource"..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '( مقفول )')
list_settings = list_settings:gsub('false', '( مفتوح )')
eueuf = eueuf:gsub('true', '( مفعل )')
eueuf = eueuf:gsub('false', '( معطل )')
return sendMsg(msg.chat_id_,1,'\n'..list_settings..eueuf..'\n')
end

function settings(msg)
list_settings = "` اعدادات المجموعه :` \n "
.."\n⇜ الهاشتاق ⇠ "..(redis:get(boss..'lock_tag'..msg.chat_id_) or 'false')
.."\n*⇜* المعرفات ⇠ "..(redis:get(boss..'lock_username'..msg.chat_id_) or 'false')
.."\n*⇜* التعديل ⇠ "..(redis:get(boss..'lock_edit'..msg.chat_id_) or 'false')
.."\n*⇜* الروابط ⇠ "..(redis:get(boss..'lock_link'..msg.chat_id_) or 'false')
.."\n\n*⇜* التكرار ⇠ "..(redis:get(boss..'lock_flood'..msg.chat_id_) or 'false')
.."\n*⇜* الكلايش ⇠ "..(redis:get(boss..'lock_spam'..msg.chat_id_) or 'false')
.."\n\n*⇜* الويب ⇠ "..(redis:get(boss..'lock_webpage'..msg.chat_id_) or 'false')
.."\n*⇜* الماركدوان ⇠ "..(redis:get(boss..'lock_markdown'..msg.chat_id_) or 'false')
.."\n*⇜* البوتات بالطرد ⇠ "..(redis:get(boss..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\n*⇜* البوتات ⇠ "..(redis:get(boss..'lock_bots'..msg.chat_id_) or 'false')
.."\n*⇜* عدد التكرار ⇠ "..(redis:get(boss..'num_msg_max'..msg.chat_id_) or 'false')
.."\n\n**` اعدادات التقـييد :`\n"
.."\n*⇜* التقييد بالتوجيه ⇠ "..(redis:get(boss..':tqeed_fwd:'..msg.chat_id_) or 'false')
.."\n*⇜* التقييد بالصور ⇠ "..(redis:get(boss..':tqeed_photo:'..msg.chat_id_) or 'false')
.."\n*⇜* التقييد بالروابط ⇠ "..(redis:get(boss..':tqeed_link:'..msg.chat_id_) or 'false')
.."\n*⇜* التقييد بالمتحركه ⇠ "..(redis:get(boss..':tqeed_gif:'..msg.chat_id_) or 'false')
.."\n*⇜* التقييد الفيديو ⇠ "..(redis:get(boss..':tqeed_video:'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '( مقفول )')
list_settings = list_settings:gsub('false', '( مفتوح )')
return sendMsg(msg.chat_id_, msg.id_,'\n'..list_settings..'\n ')
end

function media(msg)
list_settings = "**` اعدادات الوسائط:`\n"
.."\n*⇜* المتحركه ⇠ "..(redis:get(boss..'mute_gif'..msg.chat_id_) or 'false')
.."\n*⇜* الدردشه ⇠ "..(redis:get(boss..'mute_text'..msg.chat_id_) or 'false')
.."\n*⇜* الانلاين ⇠ "..(redis:get(boss..'mute_inline'..msg.chat_id_) or 'false')
.."\n*⇜* الالعاب ⇠ "..(redis:get(boss..'mute_game'..msg.chat_id_) or 'false')
.."\n*⇜* الصور ⇠ "..(redis:get(boss..'mute_photo'..msg.chat_id_) or 'false')
.."\n*⇜* الفيديو ⇠ "..(redis:get(boss..'mute_video'..msg.chat_id_) or 'false')
.."\n*⇜* الصوت ⇠ "..(redis:get(boss..'mute_audio'..msg.chat_id_) or 'false')
.."\n\n*⇜* البصمات ⇠ "..(redis:get(boss..'mute_voice'..msg.chat_id_) or 'false')
.."\n*⇜* الملصقات ⇠ "..(redis:get(boss..'mute_sticker'..msg.chat_id_) or 'false')
.."\n*⇜* الجهات ⇠ "..(redis:get(boss..'mute_contact'..msg.chat_id_) or 'false')
.."\n*⇜* التوجيه ⇠ "..(redis:get(boss..'mute_forward'..msg.chat_id_) or 'false')
.."\n*⇜* الموقع ⇠ "..(redis:get(boss..'mute_location'..msg.chat_id_) or 'false')
.."\n*⇜* الملفات ⇠ "..(redis:get(boss..'mute_document'..msg.chat_id_) or 'false')
.."\n*⇜* الاشعارات ⇠ "..(redis:get(boss..'mute_tgservice'..msg.chat_id_) or 'false')
.."\n*⇜* الكيبورد ⇠ "..(redis:get(boss..'mute_keyboard'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '( مقفول )')
list_settings = list_settings:gsub('false', '( مفتوح )')
return sendMsg(msg.chat_id_,msg.id_,'\n'..list_settings..'\n ')
end
