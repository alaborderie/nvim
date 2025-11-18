local M = {}

function M.get_git_root()
	local git_dir = vim.fs.find(".git", {
		upward = true,
		stop = vim.loop.os_homedir(),
		path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
	})[1]
	if git_dir then
		return vim.fs.dirname(git_dir)
	end
	return vim.fn.getcwd()
end

return M
