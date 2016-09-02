--[[ 
	Rework © 2016 TeslaCloud Studios
	Do not share, re-distribute or sell.
--]]

local COMMAND = Command("restart");
COMMAND.name = "Restart";
COMMAND.description = "Restarts the current map.";
COMMAND.syntax = "[number Delay]";
COMMAND.category = "server_management";
COMMAND.arguments = 0;
COMMAND.aliases = {"maprestart"};

function COMMAND:OnRun(player, delay)
	delay = tonumber(delay) or 10;

	rw.player:NotifyAll(L("MapRestartMessage", (IsValid(player) and player:Name()) or "Console", delay));

	timer.Simple(delay, function()
		RunConsoleCommand("changelevel", game.GetMap());
	end);
end;

COMMAND:Register();