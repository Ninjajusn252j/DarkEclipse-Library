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

### 1. Importa la Librería

Para usar esta librería en tu script de Delta (o cualquier exploit compatible con `game.HttpGet` y `loadstring`), simplemente copia y pega este código. La librería se cargará directamente desde tu repositorio de GitHub.

**Importante:** La librería se importa y la tabla API (`UI`) se devuelve para ser utilizada en tu script. **No se crea una variable global**, lo que ayuda a mantener tu código más limpio y evitar conflictos.

```lua
-- URL de tu librería en GitHub (¡No la cambies, ya está configurada!)
local urlDeMiLibreria = "[https://raw.githubusercontent.com/Ninjajusn252j/DarkEclipse-Library/refs/heads/main/Source.lua](https://raw.githubusercontent.com/Ninjajusn252j/DarkEclipse-Library/refs/heads/main/Source.lua)" 

local success, response = pcall(game.HttpGet, game, urlDeMiLibreria)

if success and response then
    local compiledCode = loadstring(response)
    if compiledCode then
        local UI = compiledCode() -- ¡'UI' es la tabla que contiene todas las funciones de tu librería!
        
        -- Ejemplo básico:
        local miVentana = UI.Window("Mi Primera UI", UDim2.new(0, 400, 0, 300))
        UI.Button(miVentana.Content, "¡Haz Clic!", function()
            print("¡Botón presionado!")
        end)

    else
        warn("Error: No se pudo compilar el código de la librería. Asegúrate de que el archivo Source.lua no tenga errores de sintaxis.")
    end
else
    warn("Error: No se pudo descargar la librería. Revisa tu conexión a internet o la disponibilidad del repositorio.")
end
