# 🚀 Mi Librería de UI Minimalista para Scripts 

Una librería de UI ligera y fácil de usar para scripts de Roblox ejecutados con exploits como Delta. Diseñada para ser **minimalista**, **limpia** y **completamente funcional**, permitiéndote crear interfaces de usuario atractivas con poco esfuerzo.

---

## ✨ Características

* **Minimalista:** Estilo moderno y limpio con un enfoque en la simplicidad.
* **Fácil de Usar:** API intuitiva para crear componentes de UI rápidamente.
* **Completa:** Incluye los componentes esenciales (ventanas, botones, entradas, etc.) para construir cualquier UI.
* **Personalizable:** Adapta la apariencia global con una simple configuración.
* **Arrastrable:** Las ventanas se pueden mover por la pantalla (configurable).

---

## 🛠️ Cómo Usar

### 1. Aloja la Librería

Primero, necesitas tener el código de tu librería (`ui_core.lua`) alojado en una URL accesible. Se recomienda usar:

* **GitHub Gist:** Crea un gist y usa la URL "Raw" del archivo.
* **Pastebin:** Crea un paste y usa la URL "raw" (ej. `https://pastebin.com/raw/XXXXXX`).

### 2. Importa en tu Script Delta

En tu script de Delta (o cualquier exploit compatible con `game.HttpGet` y `loadstring`), usa el siguiente código para cargar la librería:

```lua
-- Reemplaza 'TU_URL_RAW_AQUI' con la URL real de tu archivo ui_core.lua
local urlDeMiLibreria = "TU_URL_RAW_AQUI" 

local success, response = pcall(game.HttpGet, game, urlDeMiLibreria)

if success and response then
    local compiledCode = loadstring(response)
    if compiledCode then
        local UI = compiledCode() -- ¡'UI' es tu librería! Ya puedes empezar a usarla.
        
        -- Ejemplo básico:
        local miVentana = UI.Window("Mi Primera UI", UDim2.new(0, 400, 0, 300))
        UI.Button(miVentana.Content, "¡Haz Clic!", function()
            print("¡Botón presionado!")
        end)

    else
        warn("Error: No se pudo compilar el código de la librería.")
    end
else
    warn("Error: No se pudo descargar la librería. Revisa la URL o tu conexión a internet.")
end
