local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print "LSP not found, please install lspconfig"
  return
end

local handler_status_ok, handlers = pcall(require, "user.lsp.handlers")

if not handler_status_ok then
  print "LSP handlers not found, please install lspconfig"
  return
end

local mason_status_ok, mason_config = pcall(require, "user.lsp.mason")
if not mason_status_ok then
  print "LSP mason not found, please install mason"
  return
end

handlers.setup()
