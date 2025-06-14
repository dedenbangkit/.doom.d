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
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 12))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Set Transparency to 70%
;; (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; Set background color to #2E3440
;; (custom-set-faces!
;;  '(default :background "#2E3440"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Orgs/")

;; Splash Screen
(setq fancy-splash-image (concat doom-user-dir "splash.png"))

;; Custom Repos
(setq my-ideas-dir "~/Repos/akvorepos/ideas/")
(setq akvo-dir "~/Repos/akvorepos/")
(setq org-db-file "~/Orgs/database.org")
(use-package helm
  :commands helm-find-files
  :config
  (defun open-my-ideas ()
    "Write New Org Ideas."
    (interactive)
    (helm-find-files-1 my-ideas-dir))
  (defun open-akvo-dir ()
    "Open a Helm buffer to list files in Akvo Repository."
    (interactive)
    (helm-find-files-1 akvo-dir))
  (defun db-tryout()
    "Database Tryout."
    (interactive)
    (find-file "~/Orgs/database.org"))
  (map! :leader
        :desc "List of ideas"
        "f b" #'open-my-ideas)
  (map! :leader
        :desc "List of Repositories"
        "f a" #'open-akvo-dir)
  (map! :leader
        :desc "Database tryout"
        "d d" #'db-tryout)
  )

;; Org Roam
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Notes")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-db-autosync-enable))

(load "~/.doom.d/custom/org-style.el")

;; Command Log Mode
(load "~/.doom.d/custom/command-log-mode.el")
(require 'command-log-mode)
(add-hook 'LaTeX-mode-hook 'command-log-mode)

;; Keybindings
(load "~/.doom.d/keybindings.el")

;; Ensure EPG knows the location of the GPG executable
(setq epg-gpg-program "/usr/bin/gpg")

;; Path to your GPG keyring, modify as necessary
(setq epg-gpg-home-directory "/home/dedenbangkit/.gnupg")

;; Magit configuration to sign commits
(after! magit
  (setq magit-commit-arguments '("--signoff"))
  )

;; Org-reveal
(after! org
  (load-library "ox-reveal")
  (setq org-reveal-root "~/.doom.d/custom/reveal.js"))

;; Org-Bullet
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(custom-set-faces
 '(link ((t (:underline nil :weight bold :foreground "#ADD8E6"))))
 '(org-link ((t (:underline nil :weight bold :foreground "#ADD8E6"))))
 '(org-code ((t (:foreground "red"))))
 '(org-level-1 ((t (:inherit outline-1 :weight bold :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :weight bold :height 1.2))))
 '(org-level-3 ((t (:inherit outline-3 :weight bold :height 1.0)))))

;; Github Copilot
;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word))
  ;; disable logging
  :config (setq copilot-log-level 'none))


;; Dashboard

;; Change private conf icon

;; Disable recently opened files
(setq +doom-dashboard-recent-files nil)
(setq projectile-enable-caching nil)

;; Delete the dashboard menu
(assoc-delete-all "Reload last session" +doom-dashboard-menu-sections)
(assoc-delete-all "Open org-agenda" +doom-dashboard-menu-sections)
(assoc-delete-all "Recently opened files" +doom-dashboard-menu-sections)
(assoc-delete-all "Open documentation" +doom-dashboard-menu-sections)
(assoc-delete-all "Jump to bookmark" +doom-dashboard-menu-sections)

;; replace open project icon
(plist-put (alist-get "Open project" +doom-dashboard-menu-sections nil nil 'equal)
           :icon (nerd-icons-octicon "nf-oct-file_directory" :face 'doom-dashboard-menu-title))
(plist-put (alist-get "Open private configuration" +doom-dashboard-menu-sections nil nil 'equal)
           :icon (nerd-icons-octicon "nf-oct-key" :face 'doom-dashboard-menu-title))
(plist-put (alist-get "Recently opened files" +doom-dashboard-menu-sections nil nil 'equal)
           :icon (nerd-icons-octicon "nf-oct-file_symlink_file" :face 'doom-dashboard-menu-title))
;;
;; Add New Menu
(add-to-list '+doom-dashboard-menu-sections
             '("Akvo Repositories"
               :icon (nerd-icons-octicon "nf-oct-mark_github" :face 'doom-dashboard-menu-title)
               :when (file-directory-p akvo-dir)
               :action open-akvo-dir))
(add-to-list '+doom-dashboard-menu-sections
             '("Query Database"
               :icon (nerd-icons-octicon "nf-oct-database" :face 'doom-dashboard-menu-title)
               :action db-tryout))
(add-to-list '+doom-dashboard-menu-sections
             '("Org Room"
               :icon (nerd-icons-octicon "nf-oct-flame" :face 'doom-dashboard-menu-title)
               :action org-roam-node-find))
;; (add-to-list '+doom-dashboard-menu-sections
;;              '("New Ideas"
;;                :icon (all-the-icons-octicon "light-bulb" :face 'doom-dashboard-menu-title)
;;                :when (file-directory-p my-ideas-dir)
;;                :action open-my-ideas))
;;
;; (doom-dashboard-refresh-buffer)

;; gptel
(use-package! gptel
  :config
  (setq! gptel-api-key (getenv "CHATGPT_API_KEY")))

;; No New Line
(setq require-final-newline nil)

;; Autofix Python Auto Indentation with flake8
;; Max line length 79
;; (setq-hook! 'python-mode-hook +format-with-lsp nil)
;; (setq-hook! 'python-mode-hook +format-with-pyright-args '("--line-length" "79"))
;; (setq-hook! 'python-mode-hook +format-with-pyright nil)
;; (setq-hook! 'python-mode-hook +format-with-black nil)
;; (setq-hook! 'python-mode-hook +format-with-autopep8 nill)
;; (setq-hook! 'python-mode-hook +format-with-black-args '("-l" "79"))
;; (setq-hook! 'python-mode-hook
;;   flycheck-flake8-maximum-line-length 79)
;; (setq-hook! 'python-mode-hook +format-with-yapf-args '("--style" "{based_on_style: pep8, column_limit: 79}"))
;; (setq-hook! 'python-mode-hook +format-with-yapf t)
;; (use-package! blacken
;;   :after python
;;   :hook (python-mode . blacken-mode)
;;   :config
;;   (setq blacken-line-length 79))

;; Org Javascript
;; Ensure Org Babel is loaded before modifying its variables
(with-eval-after-load 'org
  ;; Require ob-js for JavaScript support
  (require 'ob-js)

  ;; Add JavaScript support to org-babel-load-languages
  (add-to-list 'org-babel-load-languages '(js . t))

  ;; Load the new configuration
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)

  ;; Add JavaScript support to org-babel-tangle-lang-exts
  (add-to-list 'org-babel-tangle-lang-exts '("js" . "js"))

  ;; Add
  (setq org-babel-python-command "/usr/bin/python"))

;; Remove last blank lines on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)
;; Enable autosave for python
(setq auto-save-default t
      auto-save-visited-interval 20) ; Autosave every 20 seconds

;; Use python-black for Python code formatting
(use-package! python-black
  :demand t
  :after python
  :hook (python-mode . python-black-on-save-mode)
  :config
  (setq python-black-command "black"
        python-black-extra-args '("--line-length" "79")))

;; Enable jinja2-mode for files with .jinja, .j2, or similar extensions
(use-package! jinja2-mode
  :mode ("\\.jinja\\'" "\\.j2\\'" "\\.jinja2\\'" "\\.html\\'")
  :config
  (add-hook 'jinja2-mode-hook #'lsp)) ; Optional: Enable LSP if you use it

;; Automatically format Python files on save
(add-hook 'python-mode-hook 'python-black-on-save-mode)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
