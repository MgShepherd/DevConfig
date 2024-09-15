local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end

local config = {
  cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
  root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  on_attach = function(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = 'auto' })

    local opts = { silent = true, buffer = bufnr }

    opts.desc = 'Navigate to test class'
    vim.keymap.set('n', 'gt', require('jdtls.tests').goto_subjects, opts)
    vim.keymap.set('n', '<leader>t', jdtls.test_class, opts)
  end,
}

local bundles = {
  vim.fn.glob(
    '~/Documents/Java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'
  ),
}

vim.list_extend(bundles, vim.split(vim.fn.glob('~/Documents/Java/vscode-java-test/server/*.jar'), '\n'))
config['init_options'] = {
  bundles = bundles,
}

jdtls.start_or_attach(config)
