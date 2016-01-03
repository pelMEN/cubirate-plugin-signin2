--
-- OnPlayerMoving()
--
--------------------------------------------------------------------------------

function OnPlayerMoving(aPlayer, aOldPosition, aNewPosition)
  local func_name = "OnPlayerMoving()";

  if not aPlayer then
    return fasle;
  end

  local bedPosition = {};
  local plPosition = {};
  local chunkLoaded = false;
  local posY = 0;
  local delta = 3; -- Delta blocks to move without authentication
  local worldObj;

  local plUID = aPlayer:GetUniqueID();

  -- Is it player registered?
  if gPlayers[plUID] == nil then
    gPlayers[plUID] = cPlayers:new();
    gPlayers[plUID]:setPlName(aPlayer:GetName());
  end

  -- Set player invisible if not authorezed
  if gPlayers[plUID]:getAuth() == false then
    aPlayer:SetVisible(false);
  else
    return false;
  end

  -- Save world link
  worldObj = aPlayer:GetWorld();

  -- Convert player current position
  plPosition = gPlayers[plUID]:getSpawnPosition();

  -- Is it player on ground?
  -- if aPlayer:IsOnGround() == false then
  -- if aPlayer:IsFlying() == true then
  --   aPlayer:SendMessage("Player is in air");
  --   -- TP player to highest block
  --   chunkLoaded, posY = worldObj:TryGetHeight(plPosition.x, plPosition.z);

  --   -- If chunk loaded - move player to ground
  --   if chunkLoaded == true then
  --     aPlayer:TeleportToCoords(plPosition.x, posY, plPosition.z);
  --     gPlayers[plUID]:setSpawnPosition(Vector3i(plPosition.x, posY, plPosition.z));
  --     return false;
  --   end
  -- end

  -- Allow player no move into some distance
  if math.abs(plPosition.x - aNewPosition.x) < delta and math.abs(plPosition.z - aNewPosition.z) < delta then
    return false;
  end

  -- Back player to spawn position
  -- gPlayers[plUID]:getSpawnPosition();
  aPlayer:TeleportToCoords(plPosition.x, plPosition.y, plPosition.z);

  -- Disable moving
  return false;
end

--------------------------------------------------------------------------------

