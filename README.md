# .doom.d

My [Doom Emacs](https://github.com/doomemacs/doomemacs) config: evil, vertico, LSP, org.

## Install

```sh
git clone git@github.com:dedenbangkit/.doom.d.git ~/Repos/personal/.doom.d
ln -s ~/Repos/personal/.doom.d ~/.config/doom
~/.config/emacs/bin/doom sync
```

Doom reads `~/.config/doom` before `~/.doom.d`, so the symlink goes there.
After changing `init.el` or `packages.el`, run `doom sync` and restart the
Emacs daemon.

### Extras

- **Copilot**: `npm install -g @github/copilot-language-server` (expects it in `~/.npm-global/bin`), then `M-x copilot-login`.
- **gptel**: reads the API key from `$CHATGPT_API_KEY`.
- **org-reveal**: put [reveal.js](https://github.com/hakimel/reveal.js) in `custom/reveal.js/` (gitignored).
- **Markdown preview**: `go install github.com/chrishrb/go-grip@latest` (renders locally, no GitHub API), then `SPC m p` in a markdown buffer.
- **Font**: JetBrainsMono Nerd Font.

## Files

| File | What |
|---|---|
| `init.el` | Doom modules |
| `packages.el` | Extra packages: copilot, gptel, ox-reveal, org-bullets, yafolding, transpose-frame, command-log-mode, python-black, jinja2-mode |
| `config.el` | Font, theme, org, magit, copilot, gptel |
| `keybindings.el` | Evil normal-state keys (below) |
| `dashboard.el` | Splash image and dashboard menu: Akvo / Personal repositories, Org Roam |

## Keys (normal state)

| Key | Action |
|---|---|
| `f f` / `f l` / `f j` | Project file / consult-buffer / switch buffer |
| `f s p` / `f s d` | Search project / current dir |
| `SPC f a` / `SPC f z` | Open `~/Repos/akvorepos` / `~/Repos/personal` |
| `SPC j` | Jump to definition |
| `s` / `Q` | Save / indent buffer |
| `M` | Magit |
| `w h/j/k/l` | Move between windows |
| `%` / `\|` | Split below / right |
| `w w` | Transpose frame |
| `C-n` | Neotree |
| `f h` / `f H` | Fold element / all |
| `f c` / `f C` | gptel chat / menu |
| `f a f` | Find org-roam note |
| `e r` | Flycheck errors |
| `F5` / `C-c t` | Revert buffer / toggle transparency |
| `SPC m p` | Markdown live preview in browser (markdown buffers) |
