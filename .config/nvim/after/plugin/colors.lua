function setColors(color)
    color = color or "badwolf"
    vim.cmd.colorscheme(color)
end

setColors()
