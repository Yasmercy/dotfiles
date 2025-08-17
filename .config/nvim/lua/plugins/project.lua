return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup {
            patterns = {
                ".git", ".venv", "Makefile", "__init.py__"
            }
        }
    end
}
