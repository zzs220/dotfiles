return {
	"sudo-tee/opencode.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				anti_conceal = { enabled = false },
				file_types = { "markdown", "opencode_output" },
			},
			ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
		},
		"saghen/blink.cmp",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("opencode").setup({
			default_global_keymaps = false,
            server = {
                url = nil,             -- URL/hostname (e.g., 'http://192.168.1.100', 'localhost', 'https://myserver.com')
                port = nil,            -- Port number (e.g., 8080), 'auto' for random port
                timeout = 10,           -- Health check timeout in seconds when connecting
                auto_kill = true,      -- Kill spawned servers when last nvim instance exits (default: true) Only applies to servers spawned by the plugin with spawn_command/kill_command
                path_map = nil,        -- Map host paths to server paths: string ('/app') or function(path) -> string
                },
			keymap = {
				editor = {
					["<leader>oo"] = { "open_input" },
					["<leader>om"] = { "configure_provider" }, -- Quick provider and model switch from predefined list
                    ['<leader>os'] = { 'select_session' }, -- Select and load a opencode session
					["<leader>oy"] = { "add_visual_selection", mode = { "v" } },
					["<leader>o/"] = { "quick_chat", mode = { "n", "x" } }, -- Open quick chat input with selection context in visual mode or current line context in normal mode
				},
				input_window = {
					["<S-cr>"] = { "submit_input_prompt", mode = { "n", "i" } }, -- Submit prompt (normal mode and insert mode)
					["<esc>"] = { "close" }, -- Close UI windows
					["<C-c>"] = { "cancel" }, -- Cancel opencode request while it is running
					["~"] = { "mention_file", mode = "i" }, -- Pick a file and add to context. See File Mentions section
					["@"] = { "mention", mode = "i" }, -- Insert mention (file/agent)
					["/"] = { "slash_commands", mode = "i" }, -- Pick a command to run in the input window
					["#"] = { "context_items", mode = "i" }, -- Manage context items (current file, selection, diagnostics, mentioned files)
					["<M-v>"] = { "paste_image", mode = "i" }, -- Paste image from clipboard as attachment
					["<tab>"] = { "toggle_pane", mode = { "n", "i" } }, -- Toggle between input and output panes
					["<up>"] = { "prev_prompt_history", mode = { "n", "i" } }, -- Navigate to previous prompt in history
					["<down>"] = { "next_prompt_history", mode = { "n", "i" } }, -- Navigate to next prompt in history
					["<M-m>"] = { "switch_mode" }, -- Switch between modes (build/plan)
					["<M-r>"] = { "cycle_variant", mode = { "n", "i" } }, -- Cycle through available model variants
				},
				output_window = {
					["<esc>"] = { "close" }, -- Close UI windows
					["<C-c>"] = { "cancel" }, -- Cancel opencode request while it is running
					["]]"] = { "next_message" }, -- Navigate to next message in the conversation
					["[["] = { "prev_message" }, -- Navigate to previous message in the conversation
					["<tab>"] = { "toggle_pane", mode = { "n", "i" } }, -- Toggle between input and output panes
					["i"] = { "focus_input", "n" }, -- Focus on input window and enter insert mode at the end of the input from the output window
					["<M-r>"] = { "cycle_variant", mode = { "n" } }, -- Cycle through available model variants
					["<leader>oS"] = { "select_child_session" }, -- Select and load a child session
				},
				session_picker = {
					rename_session = { "<C-r>" }, -- Rename selected session in the session picker
					delete_session = { "<C-d>" }, -- Delete selected session in the session picker
					new_session = { "<C-s>" }, -- Create and switch to a new session in the session picker
				},
				timeline_picker = {
					undo = { "<C-u>", mode = { "i", "n" } }, -- Undo to selected message in timeline picker
					fork = { "<C-f>", mode = { "i", "n" } }, -- Fork from selected message in timeline picker
				},
				history_picker = {
					delete_entry = { "<C-d>", mode = { "i", "n" } }, -- Delete selected entry in the history picker
					clear_all = { "<C-X>", mode = { "i", "n" } }, -- Clear all entries in the history picker
				},
				model_picker = {
					toggle_favorite = { "<C-f>", mode = { "i", "n" } },
				},
				mcp_picker = {
					toggle_connection = { "<C-t>", mode = { "i", "n" } }, -- Toggle MCP server connection in the MCP picker
				},
			},
			ui = {
				enable_treesitter_markdown = true, -- Use Treesitter for markdown rendering in the output window (default: true).
				position = "right", -- 'right' (default), 'left' or 'current'. Position of the UI split. 'current' uses the current window for the output.
				input_position = "bottom", -- 'bottom' (default) or 'top'. Position of the input window
				window_width = 0.40, -- Width as percentage of editor width
				zoom_width = 0.8, -- Zoom width as percentage of editor width
				display_model = true, -- Display model name on top winbar
				display_context_size = true, -- Display context size in the footer
				display_cost = true, -- Display cost in the footer
				window_highlight = "Normal:OpencodeBackground,FloatBorder:OpencodeBorder", -- Highlight group for the opencode window
				persist_state = true, -- Keep buffers when toggling/closing UI so window state restores quickly
				icons = {
					preset = "nerdfonts", -- 'nerdfonts' | 'text'. Choose UI icon style (default: 'nerdfonts')
					overrides = {}, -- Optional per-key overrides, see section below
				},
				questions = {
					use_vim_ui_select = false, -- If true, render questions/prompts with vim.ui.select instead of showing them inline in the output buffer.
				},
				output = {
					tools = {
						show_output = true, -- Show tools output [diffs, cmd output, etc.] (default: true)
						show_reasoning_output = true, -- Show reasoning/thinking steps output (default: true)
					},
					rendering = {
						markdown_debounce_ms = 250, -- Debounce time for markdown rendering on new data (default: 250ms)
						on_data_rendered = nil, -- Called when new data is rendered; set to false to disable default RenderMarkdown/Markview behavior
					},
				},
				input = {
					min_height = 0.10, -- min height of prompt input as percentage of window height
					max_height = 0.25, -- max height of prompt input as percentage of window height
					text = {
						wrap = false, -- Wraps text inside input window
					},
					-- Auto-hide input window when prompt is submitted or focus switches to output window
					auto_hide = false,
				},
				picker = {
					snacks_layout = nil, -- `layout` opts to pass to Snacks.picker.pick({ layout = ... })
				},
				completion = {
					file_sources = {
						enabled = true,
						preferred_cli_tool = "server", -- 'fd','fdfind','rg','git','server' if nil, it will use the best available tool, 'server' uses opencode cli to get file list (works cross platform) and supports folders
						ignore_patterns = {
							"^%.git/",
							"^%.svn/",
							"^%.hg/",
							"node_modules/",
							"%.pyc$",
							"%.o$",
							"%.obj$",
							"%.exe$",
							"%.dll$",
							"%.so$",
							"%.dylib$",
							"%.class$",
							"%.jar$",
							"%.war$",
							"%.ear$",
							"target/",
							"build/",
							"dist/",
							"out/",
							"deps/",
							"%.tmp$",
							"%.temp$",
							"%.log$",
							"%.cache$",
						},
						max_files = 10,
						max_display_length = 50, -- Maximum length for file path display in completion, truncates from left with "..."
					},
				},
			},
			context = {
				enabled = true, -- Enable automatic context capturing
				cursor_data = {
					enabled = false, -- Include cursor position and line content in the context
					context_lines = 5, -- Number of lines before and after cursor to include in context
				},
				diagnostics = {
					info = false, -- Include diagnostics info in the context (default to false
					warn = true, -- Include diagnostics warnings in the context
					error = true, -- Include diagnostics errors in the context
					only_closest = false, -- If true, only diagnostics for cursor/selection
				},
				current_file = {
					enabled = true, -- Include current file path and content in the context
					show_full_path = true,
				},
				files = {
					enabled = true,
					show_full_path = true,
				},
				selection = {
					enabled = true, -- Include selected text in the context
				},
				buffer = {
					enabled = false, -- Disable entire buffer context by default, only used in quick chat
				},
				git_diff = {
					enabled = false,
				},
			},
			logging = {
				enabled = false,
				level = "warn", -- debug, info, warn, error
				outfile = nil,
			},
            quick_chat = {
                default_model = nil,   -- works better with a fast model like gpt-4.1
                default_agent = nil, -- Uses the current mode when nil
                instructions = "You are in quick chat mode - a temporary session with narrow context for small, targeted code edits. Be concise and make minimal, focused changes.",
            },
		})
	end,
}
