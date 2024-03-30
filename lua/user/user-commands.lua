function ConvertIframesToYoutube()
    vim.api.nvim_exec(
        [[
        %s/<Iframe videoID='\(.\{-}\)' \/>/{% youtube \1 %}/g
    ]],
        true
    )
end

vim.api.nvim_create_user_command("ConvertIframesToYoutube", ConvertIframesToYoutube, {})
