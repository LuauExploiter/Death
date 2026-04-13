# Almost 1:1 Death Emote from TSB

A repo for recreating the **Death emote** from **The Strongest Battlegrounds** as accurately as possible with local runtime code, ripped/source-backed data, and serialized VFX.

## Features
- almost 1:1 Death emote recreation
- local animation, VFX, camera, and sound handling
- source-backed setup for easier fixing and updating

## Run
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuauExploiter/Death/refs/heads/main/bootstrap.lua"))()
```

## Notes
- `src/Emotes/Death/` = final cleaned Death files
- `imports/raw/Death/` = raw source/reference files
- `assets/vfx/death/BadWolf.lua` = serialized Death VFX bundle
