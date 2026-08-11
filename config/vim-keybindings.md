# Custom Commands & Mappings

All mappings below use `<leader>` = `<Space>`.

### Buffers

| Mapping | Action |
|---------|--------|
| `<leader>bn` | Next buffer (`:bnext`) |
| `<leader>bp` | Previous buffer (`:bprev`) |
| `<leader>bb` | Toggle to last-used buffer (`<C-^>`) |
| `<leader>bd` | Delete/close current buffer (`:bdelete`) |
| `<leader>bl` | List buffers, then prompt for a buffer to jump to (`:ls` + `:b `) |

### File Explorer (netrw)

| Mapping | Action |
|---------|--------|
| `<leader>e` | Toggle the file explorer as a 40-column vertical split on the left |

`ToggleExplorer()` is smart: if a netrw window is already open it closes it,
otherwise it opens `:Vex` on the left (temporarily flipping `netrw_altv` so the
explorer lands on the left while files still open to the right).

**Opening Vim on a directory** (e.g. `vim ~/notes`): `DirStart()` runs on
`VimEnter` and, when the single argument is a directory, creates an empty edit
window to the right of the startup netrw and sizes the explorer to 40 columns.
This means selecting a file opens it in the right-hand window instead of
splitting below — matching the `<leader>e` layout. It only triggers for a
single directory argument, so `vim file.txt` and multi-file opens are unaffected.

### Windows

| Mapping | Action |
|---------|--------|
| `<leader>w` | Cycle to the next window (`<C-w>w`) |
| `<leader><Left>` | Shrink window width by 10 |
| `<leader><Right>` | Grow window width by 10 |
| `<leader><Up>` | Grow window height by 10 |
| `<leader><Down>` | Shrink window height by 10 |

### Terminal

| Mapping | Mode | Action |
|---------|------|--------|
| `<leader>t` | Normal | Toggle a 10-row terminal at the bottom |
| `<leader>t` | Terminal | Leave insert, then toggle (hide) the terminal |
| `<leader>w` | Terminal | Move to the window above (`<C-w>k`) |

`ToggleTerminal()` reuses an existing terminal buffer when possible: it hides
the terminal window if visible, re-shows the existing terminal buffer if hidden,
or spawns a new `botright terminal` if none exists.

### Search

| Mapping | Action |
|---------|--------|
| `<leader>/` | Clear search highlighting (`:nohlsearch`) |

## Editor Settings

### Appearance
- `colorscheme retrobox`
- `number` + `relativenumber` — hybrid line numbers.
- `laststatus=2` — always show the status line; `ruler` and `showmode` on.
- `nowrap` — long lines don't wrap.
- `scrolloff=8` — keep 8 lines of context above/below the cursor.

### Indentation
- `expandtab` — tabs become spaces.
- `shiftwidth=4`, `tabstop=4` — 4-space indentation.
- `smarttab` + `smartindent` — context-aware indenting.

### Search Behavior
- `hlsearch` + `incsearch` — highlight matches and search as you type.
- `ignorecase` + `smartcase` — case-insensitive unless the query has a capital.

### Editing / Files
- `mouse=a` — mouse enabled in all modes.
- `clipboard=unnamed,unnamedplus` — yanks/pastes use the system clipboard.
- `hidden` — switch away from modified buffers without saving.
- `noswapfile` — no `.swp` files.
- `wildmenu` — enhanced command-line completion.

### netrw options
- `netrw_liststyle = 3` — tree view.
- `netrw_banner = 0` — hide the top banner.
- `netrw_browse_split = 4` — open selected files in the previous window.
- `netrw_altv = 1` — vertical splits open to the right.

## Miscellaneous

**Yank highlight**: when `TextYankPost` is available, yanked text is briefly
highlighted (`Visual` group) for 300ms via `matchadd` + a timer, mimicking
Neovim's `highlight_yank`.

