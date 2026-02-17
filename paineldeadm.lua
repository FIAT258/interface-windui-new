debugX = true

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Configuração da janela principal (mantida igual)
local Window = Rayfield:CreateWindow({
   Name = "Admin Panel",
   LoadingTitle = "Carregando Interface",
   LoadingSubtitle = "Por Sirius",
   ConfigurationSaving = {
      Enabled = true,
      FileName = "AdminPanelConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink"
   },
   KeySystem = false
})

-- Função melhorada para enviar mensagens no chat
local function SendChatMessage(msg)
   if game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") then
      game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
   else
      -- Método alternativo caso o primeiro não funcione
      game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(msg)
   end
end

-- Tab "Admin"
local AdminTab = Window:CreateTab("Admin", 7120897394)

-- Sistema de dropdown de jogadores melhorado
local PlayersDropdown
local function GetPlayerNames()
   local players = {}
   for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
      if player ~= game:GetService("Players").LocalPlayer then
         table.insert(players, player.Name)
      end
   end
   return players
end

local function UpdatePlayerList()
   local playerNames = GetPlayerNames()
   PlayersDropdown:Set(playerNames)
   if #playerNames == 0 then
      PlayersDropdown:Set({"Nenhum jogador encontrado"})
   end
end

PlayersDropdown = AdminTab:CreateDropdown({
   Name = "Selecione um Jogador",
   Options = GetPlayerNames(),
   CurrentOption = "",
   Flag = "PlayerList",
   Callback = function(Option) end
})

-- Atualiza a lista quando jogadores entram/saem
game:GetService("Players").PlayerAdded:Connect(function(player)
   UpdatePlayerList()
   Rayfield:Notify({
      Title = "Jogador Entrou",
      Content = player.Name .. " entrou no jogo.",
      Duration = 3,
      Image = 7120897394
   })
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
   UpdatePlayerList()
   Rayfield:Notify({
      Title = "Jogador Saiu",
      Content = player.Name .. " saiu do jogo.",
      Duration = 3,
      Image = 7120897394
   })
end)

-- Botões de comandos com verificação melhorada
AdminTab:CreateButton({
   Name = "Freeze Player",
   Callback = function()
      if PlayersDropdown.CurrentOption ~= "" and PlayersDropdown.CurrentOption ~= "Nenhum jogador encontrado" then
         SendChatMessage("frezeexfirexpainel2.0 " .. PlayersDropdown.CurrentOption)
      end
   end
})

AdminTab:CreateButton({
   Name = "Kick Player",
   Callback = function()
      if PlayersDropdown.CurrentOption ~= "" and PlayersDropdown.CurrentOption ~= "Nenhum jogador encontrado" then
         SendChatMessage("xfirexkick " .. PlayersDropdown.CurrentOption)
      end
   end
})

AdminTab:CreateButton({
   Name = "Crash Player",
   Callback = function()
      if PlayersDropdown.CurrentOption ~= "" and PlayersDropdown.CurrentOption ~= "Nenhum jogador encontrado" then
         SendChatMessage("crashxfirex " .. PlayersDropdown.CurrentOption)
      end
   end
})

AdminTab:CreateButton({
   Name = "Jail Player",
   Callback = function()
      if PlayersDropdown.CurrentOption ~= "" and PlayersDropdown.CurrentOption ~= "Nenhum jogador encontrado" then
         SendChatMessage("jailxfirex " .. PlayersDropdown.CurrentOption)
      end
   end
})

-- Sistema de visualização do jogador
local Camera = workspace.CurrentCamera
local ViewingPlayer = false
local ViewConnection

AdminTab:CreateToggle({
   Name = "View Player",
   CurrentValue = false,
   Callback = function(Value)
      ViewingPlayer = Value
      if Value then
         local targetPlayer = game:GetService("Players"):FindFirstChild(PlayersDropdown.CurrentOption)
         if targetPlayer and targetPlayer.Character then
            local humanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
               Camera.CameraType = Enum.CameraType.Scriptable
               ViewConnection = game:GetService("RunService").RenderStepped:Connect(function()
                  if ViewingPlayer and humanoidRootPart then
                     Camera.CFrame = CFrame.new(humanoidRootPart.Position + Vector3.new(0, 5, -10), humanoidRootPart.Position)
                  end
               end)
            end
         end
      else
         if ViewConnection then
            ViewConnection:Disconnect()
         end
         Camera.CameraType = Enum.CameraType.Custom
      end
   end
})

-- Aviso
AdminTab:CreateLabel("⚠️ Esses comandos só funcionam com o script completo!")

-- Tab "FE ADMIN"
local FEAdminTab = Window:CreateTab("FE ADMIN", 123890908152523)
FEAdminTab:CreateLabel("EM BREVE :D")

-- Atualiza a lista de jogadores imediatamente
UpdatePlayerList()

Rayfield:LoadConfiguration()
