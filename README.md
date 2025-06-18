# 🌑 DarkEclipse UI Library

This documentation is for the stable release of **DarkEclipse UI Library**, a custom-built, minimalist, and fully functional UI solution designed for Roblox exploit scripts. It empowers developers to create sleek and intuitive user interfaces with ease.

---

## ✨ Features

* **Minimalist Design:** Clean, modern aesthetic with a focus on core functionality.
* **Easy-to-Use API:** Simple and intuitive functions for quick UI component creation.
* **Essential Components:** Includes fundamental UI elements like Windows, Buttons, Inputs, Toggles, and Sliders.
* **Customizable:** Adapt global styling (fonts, colors, spacing) to match your script's theme.
* **Draggable Windows:** User interfaces can be freely repositioned by dragging their title bars.

---

## 🛠️ How to Use

### 1. Booting the Library

To use DarkEclipse UI in your Roblox exploit script (compatible with `game:HttpGet` and `loadstring` like Delta), simply copy and paste the following code. The library will be fetched directly from its GitHub repository.

**Important:** The library is loaded and its API table (`UI`) is returned for direct use in your script. It **does not create a global variable**, which helps keep your codebase cleaner and prevents naming conflicts.

```lua
-- URL de tu librería DarkEclipse UI en GitHub
local DarkEclipseUiUrl = "[https://raw.githubusercontent.com/Ninjajusn252j/DarkEclipse-Library/refs/heads/main/Source.lua](https://raw.githubusercontent.com/Ninjajusn252j/DarkEclipse-Library/refs/heads/main/Source.lua)" 

local success, response = pcall(game.HttpGet, game, DarkEclipseUiUrl)

if success and response then
    local compiledCode = loadstring(response)
    if compiledCode then
        local UI = compiledCode() -- 'UI' now holds the entire DarkEclipse UI API!
        
        -- You can now start building your UI!
        local myWindow = UI.Window("My First DarkEclipse UI")
        -- ... add components to your window
    else
        warn("Error: No se pudo compilar el código de la librería. Asegúrate de que el archivo Source.lua no tenga errores de sintaxis.")
    end
else
    warn("Error: No se pudo descargar la librería. Revisa tu conexión a internet o la disponibilidad del repositorio.")
end
