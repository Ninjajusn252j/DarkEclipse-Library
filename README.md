# 🚀 Orion Library

This documentation is for the stable release of Orion Library, a powerful and minimalist UI solution designed to streamline the creation of user interfaces for Roblox exploits like Delta.

---

## ✨ Features

* **Minimalist Design:** Modern and clean aesthetics with a focus on simplicity.
* **Easy to Use:** Intuitive API for rapid UI component creation.
* **Comprehensive:** Includes all essential components (windows, buttons, inputs, etc.) to build any UI.
* **Customizable:** Adapt the global look and feel with simple configuration options.
* **Draggable Windows:** User interfaces can be easily repositioned on screen (configurable).

---

## 🛠️ How to Use

### 1. Booting the Library

To use Orion Library, you need to load it into your script. This process uses `game:HttpGet` to fetch the library's code from the specified URL and `loadstring` to execute it safely within your script environment.

**Important:** The library is loaded and its API table (`OrionLib`) is returned for direct use in your script. It **does not create a global variable**, which helps keep your codebase cleaner and prevents naming conflicts.

```lua
-- URL of the Orion Library on GitHub (this is pre-configured, no changes needed!)
local OrionLibUrl = "[https://raw.githubusercontent.com/Ninjajusn252j/DarkEclipse-Library/refs/heads/main/Source.lua](https://raw.githubusercontent.com/Ninjajusn252j/DarkEclipse-Library/refs/heads/main/Source.lua)" 

local success, response = pcall(game.HttpGet, game, OrionLibUrl)

if success and response then
    local compiledCode = loadstring(response)
    if compiledCode then
        local OrionLib = compiledCode() -- 'OrionLib' now holds the entire library API!
        
        -- You can now start building your UI!
        local myWindow = OrionLib:MakeWindow({Name = "My First UI"})
        -- ... add components to your window
    else
        warn("Error: Failed to compile the library code. Ensure Source.lua does not have syntax errors.")
    end
else
    warn("Error: Failed to download the library. Check your internet connection or repository availability.")
end
