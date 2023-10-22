function setColors(color)
    color = color or "github_dark_dimmed"
    vim.cmd.colorscheme(color)
end

setColors()
