vim.diagnostic.config({virtual_text=true})
VirtualLineEnabled = false
function ToggleVL()
    VirtualLineEnabled = not VirtualLineEnabled
    vim.diagnostic.config({virtual_lines = VirtualLineEnabled, virtual_text=not VirtualLineEnabled})
end
