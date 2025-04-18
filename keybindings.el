;;; keybindings.el --- Initialization keybindings for Emacs
;;; Commentary
;;; Code:
;;;
;;;

;; Extra Spaces
(define-key evil-normal-state-map (kbd "SPC j") #'dumb-jump-go)

(defun indent-buffer ()
  "Apply indentation rule to the entire buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(define-key evil-normal-state-map (kbd "Q") 'indent-buffer)

;; Remap :q to kill buffer
(map!
 [remap evil-quit] #'kill-current-buffer)

(defun remove-all-buffer-except-scratch ()
  (interactive)
  "Invalidate all projectile caches"
  (projectile-invalidate-cache nil)
  "Kill all buffers except *scratch* and *doom*"
  (dolist (buffer (buffer-list))
    (unless (or (string= (buffer-name buffer) "*scratch*")
                (string= (buffer-name buffer) "*doom*")
                (string= (buffer-name buffer) "*Messages*"))
      (kill-buffer buffer))))

;; For leader f
(global-set-key (kbd "<f5>") #'revert-buffer-quick)
(define-key evil-normal-state-map (kbd "%") 'helm-ext-ff-execute-horizontal-split)
(define-key evil-normal-state-map (kbd "|") 'helm-ext-ff-execute-vertical-split)

;; Quick View
(define-key evil-normal-state-map (kbd "ff") #'projectile-find-file)
(define-key evil-normal-state-map (kbd "fl") #'helm-mini)
(define-key evil-normal-state-map (kbd "fj") #'helm-buffers-list)
;; Remove all helm buffers
(define-key evil-normal-state-map (kbd "fJ") 'remove-all-buffer-except-scratch)
(define-key evil-normal-state-map (kbd "fp") 'find-file-literally-at-point)
(define-key evil-normal-state-map (kbd "fss") 'find-ag)
(define-key evil-normal-state-map (kbd "fsd") #'helm-do-ag)
(define-key evil-normal-state-map (kbd "fsh") #'helm-ag-pop-stack)
(define-key evil-normal-state-map (kbd "fsp") #'helm-ag-project-root)
(define-key evil-normal-state-map (kbd "fsb") #'helm-ag-buffers)

(define-key evil-normal-state-map (kbd "f SPC") #'keyboard-escape-quit)
(define-key evil-normal-state-map (kbd "f <escape>") #'keyboard-escape-quit)

;; Indentation
;; (define-key evil-visual-state-map (kbd "SPC") #'indent-region)
;; (defun window-length ()
;;   (let ((wlen (mapcar #'window-buffer (window-list))))
;;     (message (type-of wlen))
;;           ))

;; (window-length)

;; Magit
(define-key evil-normal-state-map (kbd "M") #'magit)

;; Global Moving
(define-key evil-normal-state-map (kbd "(")  'evil-previous-open-paren)
(define-key evil-normal-state-map (kbd ")")  'evil-next-close-paren)

;; Neotree
(setq neo-smart-open t)
(define-key evil-normal-state-map (kbd "C-n") #'neotree-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "I") #'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "L") #'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "R") #'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "ma") #'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "mx") #'neotree-rename-node)
(evil-define-key 'normal neotree-mode-map (kbd "mc") #'neotree-copy-node)
(evil-define-key 'normal neotree-mode-map (kbd "md") #'neotree-delete-node)
(evil-define-key 'normal neotree-mode-map (kbd "i") #'neotree-hidden-file-toggle)

;; Windows
(define-key evil-normal-state-map (kbd "wl") #'windmove-right)
(define-key evil-normal-state-map (kbd "wh") #'windmove-left)
(define-key evil-normal-state-map (kbd "wj") #'windmove-down)
(define-key evil-normal-state-map (kbd "wk") #'windmove-up)
(define-key evil-normal-state-map (kbd "wd") #'evil-window-delete)
(define-key evil-normal-state-map (kbd "ww") #'transpose-frame)
(define-key evil-normal-state-map (kbd "wH") #'evil-window-move-far-left)
(define-key evil-normal-state-map (kbd "wL") #'evil-window-move-far-right)
(define-key evil-normal-state-map (kbd "wc") #'global-command-log-mode)
(define-key evil-normal-state-map (kbd "w SPC") #'clm/toggle-command-log-buffer)
(define-key evil-normal-state-map (kbd "w+") 'evil-window-increase-height)
(define-key evil-normal-state-map (kbd "w-") 'evil-window-decrease-height)
(define-key evil-normal-state-map (kbd "w(") 'evil-window-increase-width)
(define-key evil-normal-state-map (kbd "w)") 'evil-window-decrease-width)
(define-key evil-normal-state-map (kbd "%") #'split-window-below)
(define-key evil-normal-state-map (kbd "|") #'split-window-right)

;; Modes
(define-prefix-command 'modes)
(define-key evil-normal-state-map (kbd "fm") #'modes)
(define-key evil-normal-state-map (kbd "fml") #'lisp-mode)
(define-key evil-normal-state-map (kbd "fmo") #'org-mode)
(define-key evil-normal-state-map (kbd "fmc") #'clojure-mode)
(define-key evil-normal-state-map (kbd "fm <escape>") #'keyboard-escape-quit)

;; Flycheck
(define-key evil-normal-state-map (kbd "er") 'flycheck-list-errors)

;; Lisp
(add-hook
 'emacs-lisp-mode-hook
 #'(lambda ()
     (define-key evil-normal-state-map (kbd "eb") 'eval-buffer)
     (define-key evil-normal-state-map (kbd "eb") 'eval-buffer)))

;; Clojure Cider
(add-hook
 'clojure-mode-hook
 #'(lambda ()
     (define-key evil-normal-state-map (kbd "ec") 'cider-connect)
     (define-key evil-normal-state-map (kbd "eb") 'cider-eval-buffer)
     (define-key evil-normal-state-map (kbd "ee") 'cider-eval-list-at-point)
     (define-key evil-normal-state-map (kbd "ew") 'cider-repl-clear-buffer)
     (define-key evil-normal-state-map (kbd "ej") 'cider-find-var)
     (define-key evil-normal-state-map (kbd "ek") 'cider-pop-back)
     (define-key evil-normal-state-map (kbd "et") 'cider-test-run-test)
     (define-key evil-normal-state-map (kbd "eq") 'cider-quit)
     (define-key evil-normal-state-map (kbd "ed") 'cider-debug-defun-at-point)
     (define-key evil-normal-state-map (kbd "e <escape>") 'keyboard-escape-quit)))

;; Org Custom Evil
(defun my-org-local-keybindings ()
  "Define local keybindings for Org mode."
  (define-key evil-normal-state-local-map (kbd "S-<tab>") 'org-cycle-hide-drawers))

;; Org Roam
(define-key evil-normal-state-map (kbd "faf") #'org-roam-node-find)
(define-key evil-normal-state-map (kbd "faa") #'org-roam-buffer-toggle)
(define-key evil-normal-state-map (kbd "fan") #'org-roam-node-insert)


(defun my-org-global-show-all ()
  "Show all headings in all Org mode buffers."
  (interactive)
  (add-hook 'org-mode-hook #'my-org-local-keybindings)
  (org-show-all))

(defun my-org-hide-all ()
  "Hide all headings and remove local keybindings in Org mode."
  (interactive)
  (remove-hook 'org-mode-hook #'my-org-local-keybindings)
  (org-hide-all)
  (define-key evil-normal-state-local-map (kbd "S-<tab>") 'global-org-show-all))

(add-hook
 'org-mode-hook
 #'(lambda ()
     (define-key evil-normal-state-map (kbd "S-<tab>") 'my-org-global-show-all)
     (define-key evil-normal-state-map (kbd "fd") 'org-time-stamp)
     (define-key evil-normal-state-map (kbd "fe") 'org-table-export)
     (define-key evil-normal-state-map (kbd "L") 'org-cycle)
     (define-key evil-normal-state-map (kbd "R") 'org-export-dispatch)
     (define-key evil-normal-state-map (kbd ">") 'org-table-wrap-region)
     (define-key evil-normal-state-map (kbd "+") 'org-toggle-checkbox)
     (define-key evil-normal-state-map (kbd "#") 'org-insert-structure-template)
     (define-key evil-normal-state-map (kbd "-") 'org-ctrl-c-minus)))

;; Python Custom
(add-hook
 'python-mode-hook
 #'(lambda ()
     '(jedi-mode)
     (define-key evil-normal-state-map (kbd "ef") 'lsp-goto-type-definition)
     (define-key evil-normal-state-map (kbd "ej") 'jedi:goto-definition)
     (define-key evil-normal-state-map (kbd "ee") 'elpy-yapf-fix-code)
     (define-key evil-normal-state-map (kbd "ed") 'jedi:show-doc)))

;; Folding
(defvar yafolding-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key evil-normal-state-map (kbd "fg") #'yafolding-hide-parent-element)
    (define-key evil-normal-state-map (kbd "fH") #'yafolding-toggle-all)
    (define-key evil-normal-state-map (kbd "fh") #'yafolding-toggle-element)
    map))

;; (evil-ex-define-cmd "q[uit]" nil)

;; custom patch
(fset 'evil-visual-update-x-selection 'ignore)

;;; keybindings.el ends here
