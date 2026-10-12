;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Deden Bangkit"
      user-mail-address "deden@akvo.org")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; Same font as the rest of the Sway setup (foot, waybar). 14px, not 10pt:
;; Emacs rounds 10pt to 13px, which looks squat next to foot (≈13.3px).
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;; Specify both a dark and light theme, like so and Doom will choose which one
;; to load based on your system light/dark setting:
;;
;;   (setq doom-theme '(doom-one   . doom-one-light))   ; (DARK . LIGHT)
;;
;; If you want more pro-active theme switching based on OS light/dark mode, look
;; up the `auto-dark' package.

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Make line numbers white with darker background (not pure black)
;; Current line number uses highlighted line styling
(custom-set-faces!
  '(line-number :foreground "#ffffff" :background "#21242b")
  '(line-number-current-line :foreground "#282c34" :background "#51afef" :weight bold))

;; Add visual separator between line numbers and code
(setq display-line-numbers-width-start t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Orgs/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(load! "keybindings")
(load! "dashboard")

;; ---------------------------------------------------------------------------
;; Ported from dedenbangkit/.doom.d config.el
;; ---------------------------------------------------------------------------

;; Org styling (was custom/org-style.el + custom.el)
(custom-set-faces!
  '(link :underline nil :weight bold :foreground "#ADD8E6")
  '(org-link :underline nil :weight bold :foreground "#ADD8E6")
  '(org-code :foreground "red")
  '(org-level-1 :inherit outline-1 :weight bold :height 1.5)
  '(org-level-2 :inherit outline-2 :weight bold :height 1.2)
  '(org-level-3 :inherit outline-3 :weight bold :height 1.0))
(add-hook 'org-mode-hook #'org-bullets-mode)

;; Command Log Mode
(use-package! command-log-mode
  :commands (global-command-log-mode clm/toggle-command-log-buffer))
(add-hook 'LaTeX-mode-hook #'command-log-mode)

;; Ensure EPG knows the location of the GPG executable
(setq epg-gpg-program "/usr/bin/gpg"
      epg-gpg-home-directory (expand-file-name "~/.gnupg"))

;; Magit: sign off commits by default
(after! transient
  (unless (assq 'magit-commit transient-values)
    (push '(magit-commit "--signoff") transient-values)))

;; Org-reveal (reveal.js copied from the old ~/.doom.d/custom/reveal.js)
(after! org
  (require 'ox-reveal)
  (setq org-reveal-root (concat "file://" (expand-file-name "custom/reveal.js" doom-user-dir))))

;; Github Copilot - copilot-emacs/copilot.el
;; Server: npm install -g @github/copilot-language-server (in ~/.npm-global)
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-c C-n" . copilot-next-completion)
              ("C-c C-p" . copilot-previous-completion))
  :config
  (setq copilot-node-executable "node"
        copilot-server-executable (expand-file-name "~/.npm-global/bin/copilot-language-server"))
  (add-to-list 'warning-suppress-types '(copilot copilot-no-mode-indent)))

;; gptel - ChatGPT Integration (key from $CHATGPT_API_KEY)
(use-package! gptel
  :defer t
  :config
  (setq gptel-api-key (getenv "CHATGPT_API_KEY")
        gptel-model 'gpt-4o
        gptel-default-mode 'org-mode
        gptel-stream t
        gptel-temperature 0.7
        gptel-max-tokens 4096))

;; No New Line
(setq require-final-newline nil)

;; Org Javascript
(after! org
  (require 'ob-js)
  (add-to-list 'org-babel-load-languages '(js . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (add-to-list 'org-babel-tangle-lang-exts '("js" . "js"))
  (setq org-babel-python-command "python3"))

;; Remove last blank lines on save
(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-hook 'before-save-hook #'whitespace-cleanup)
;; Enable autosave
(setq auto-save-default t
      auto-save-visited-interval 20) ; Autosave every 20 seconds

;; Use python-black for Python code formatting (needs `black')
(use-package! python-black
  :after python
  :hook ((python-mode python-ts-mode) . python-black-on-save-mode)
  :config
  (setq python-black-command "black"
        python-black-extra-args '("--line-length" "79")))

;; Enable jinja2-mode for files with .jinja, .j2, or similar extensions
(use-package! jinja2-mode
  :mode ("\\.jinja\\'" "\\.j2\\'" "\\.jinja2\\'" "\\.html\\'")
  :config
  (add-hook 'jinja2-mode-hook #'lsp-deferred))

;; Folding (f g / f h / f H): yafolding has no autoloads, so declare them
(use-package! yafolding
  :commands (yafolding-hide-parent-element yafolding-toggle-all yafolding-toggle-element))
