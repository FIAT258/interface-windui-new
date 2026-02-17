debugX = true

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "XFIREX HUB (PAINEL DE ADM) BY FIAT",
   Icon = 7120897394, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "carregando O PAINEL :3",
   LoadingSubtitle = "by fiat",
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

-- Tab "Admin"
local AdminTab = Window:CreateTab("Admin", 7120897394) -- Título e ID da imagem

-- Dropdown de Players (atualiza automaticamente)
local PlayersDropdown
local function UpdatePlayersDropdown()
   local Players = game:GetService("Players"):GetPlayers()
   local PlayerNames = {}
   for _, Player in ipairs(Players) do
      table.insert(PlayerNames, Player.Name)
   end
   PlayersDropdown:Set(PlayerNames)
end

PlayersDropdown = AdminTab:CreateDropdown({
   Name = "Selecione um Jogador",
   Options = {},
   CurrentOption = "",
   Flag = "PlayerDropdown",
   Callback = function(Option)
      -- Nada aqui, apenas seleção
   end,
})

-- Atualiza o dropdown quando um jogador entra/sai
game:GetService("Players").PlayerAdded:Connect(function()
   UpdatePlayersDropdown()
   Rayfield:Notify({
      Title = "Jogador Entrou",
      Content = "Um jogador entrou no servidor.",
      Duration = 3,
      Image = 7120897394,
   })
end)

game:GetService("Players").PlayerRemoving:Connect(function(Player)
   UpdatePlayersDropdown()
   Rayfield:Notify({
      Title = "Jogador Saiu",
      Content = Player.Name .. " saiu do servidor.",
      Duration = 3,
      Image = 7120897394,
   })
end)

-- Botão Freeze Player
AdminTab:CreateButton({
   Name = "Freeze Player",
   Callback = function()
      local SelectedPlayer = PlayersDropdown.CurrentOption
      if SelectedPlayer ~= "" then
         game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
            "frezeexfirexpainel2.0 " .. SelectedPlayer,
            "All"
         )
      end
   end,
})

-- Botão Kick Player
AdminTab:CreateButton({
   Name = "Kick Player",
   Callback = function()
      local SelectedPlayer = PlayersDropdown.CurrentOption
      if SelectedPlayer ~= "" then
         game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
            "xfirexkick " .. SelectedPlayer,
            "All"
         )
      end
   end,
})

-- Botão Crash Player
AdminTab:CreateButton({
   Name = "Crash Player",
   Callback = function()
      local SelectedPlayer = PlayersDropdown.CurrentOption
      if SelectedPlayer ~= "" then
         game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
            "crashxfirex " .. SelectedPlayer,
            "All"
         )
      end
   end,
})

-- Botão Jail Player
AdminTab:CreateButton({
   Name = "Jail Player",
   Callback = function()
      local SelectedPlayer = PlayersDropdown.CurrentOption
      if SelectedPlayer ~= "" then
         game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
            "jailxfirex " .. SelectedPlayer,
            "All"
         )
      end
   end,
})

-- Aviso de que só funciona com o script grátis
AdminTab:CreateLabel("⚠️ Essas coisas só funcionam para quem está usando o script grátis!")

-- Toggle para seguir o jogador
local FollowingPlayer = false
local CurrentFollowTarget = nil
local Camera = workspace.CurrentCamera

AdminTab:CreateToggle({
   Name = "View Player",
   CurrentValue = false,
   Flag = "ViewPlayerToggle",
   Callback = function(Value)
      FollowingPlayer = Value
      if Value then
         local SelectedPlayer = PlayersDropdown.CurrentOption
         if SelectedPlayer ~= "" then
            local Player = game:GetService("Players"):FindFirstChild(SelectedPlayer)
            if Player and Player.Character then
               CurrentFollowTarget = Player.Character
               coroutine.wrap(function()
                  while FollowingPlayer and CurrentFollowTarget and CurrentFollowTarget:FindFirstChild("HumanoidRootPart") do
                     Camera.CameraType = Enum.CameraType.Scriptable
                     Camera.CFrame = CFrame.new(
                        CurrentFollowTarget.HumanoidRootPart.Position + Vector3.new(0, 5, -10),
                        CurrentFollowTarget.HumanoidRootPart.Position
                     )
                     wait()
                  end
                  Camera.CameraType = Enum.CameraType.Custom
               end)()
            end
         end
      else
         CurrentFollowTarget = nil
         Camera.CameraType = Enum.CameraType.Custom
      end
   end,
})

-- Tab "FE ADMIN"
local FEAdminTab = Window:CreateTab("FE ADMIN", 123890908152523) -- Título e ID da imagem
FEAdminTab:CreateLabel("EM BREVE :D")

-- Inicializa o dropdown
UpdatePlayersDropdown()

Rayfield:LoadConfiguration()
