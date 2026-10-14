;;; keybindings.el --- Ported from dedenbangkit/.doom.d -*- lexical-binding: t; -*-
;;; Commentary:
;; Same keys as ~/.doom.d/keybindings.el on the old machine. helm commands
;; are swapped for the vertico/consult equivalents. A few extras from the
;; older ~/.emacs.d are kept where they don't clash (s, f n, f b, Y/P, C-c t).
;;; Code:

(setq which-key-idle-delay 0.01)
(autoload 'find-file-literally-at-point "ffap" nil t)

;; Extra Spaces
(map! :leader :desc "Jump to definition" "j" #'+lookup/definition)

(defun indent-buffer ()
  "Apply indentation rule to the entire buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

;; Remap :q to kill buffer
(map! [remap evil-quit] #'kill-current-buffer)

(defun remove-all-buffer-except-scratch ()
  "Invalidate projectile caches and kill all buffers except *scratch*, *doom* and *Messages*."
  (interactive)
  (projectile-invalidate-cache nil)
  (dolist (buffer (buffer-list))
    (unless (member (buffer-name buffer) '("*scratch*" "*doom*" "*Messages*"))
      (kill-buffer buffer))))

(defun toggle-transparency ()
  "Toggle background transparency."
  (interactive)
  (set-frame-parameter
   nil 'alpha-background
   (if (eql (frame-parameter nil 'alpha-background) 100) 95 100)))
(add-to-list 'default-frame-alist '(alpha-background . 100))

(map! "<f5>" #'revert-buffer-quick
      "C-c t" #'toggle-transparency)

(map!
 :n "Q" #'indent-buffer

 ;; Quick View
 :n "f f"   #'projectile-find-file
 :n "f l"   #'consult-buffer                    ; was helm-mini
 :n "f j"   #'switch-to-buffer                  ; was helm-buffers-list
 :n "f J"   #'remove-all-buffer-except-scratch
 :n "f p"   #'find-file-literally-at-point
 :n "f s s" #'+default/find-file-under-here     ; was find-ag
 :n "f s d" #'+default/search-cwd               ; was helm-do-ag
 :n "f s h" #'better-jumper-jump-backward       ; was helm-ag-pop-stack
 :n "f s p" #'+default/search-project           ; was helm-ag-project-root
 :n "f s b" #'consult-line-multi                ; was helm-ag-buffers
 :n "f SPC"      #'keyboard-escape-quit
 :n "f <escape>" #'keyboard-escape-quit
 ;; kept from ~/.emacs.d
 :n "f b"   #'consult-bookmark
 :n "f n"   #'doom/toggle-line-numbers
 :n "s"     #'save-buffer
 :v "Y"     #'clipboard-kill-ring-save
 :n "P"     #'clipboard-yank

 ;; Magit
 :n "M" #'magit

 ;; Global Moving
 :n "(" #'evil-previous-open-paren
 :n ")" #'evil-next-close-paren

 ;; Neotree
 :n "C-n" #'neotree-toggle

 ;; Windows
 :n "w l" #'windmove-right
 :n "w h" #'windmove-left
 :n "w j" #'windmove-down
 :n "w k" #'windmove-up
 :n "w d" #'evil-window-delete
 :n "w w" #'transpose-frame
 :n "w H" #'evil-window-move-far-left
 :n "w L" #'evil-window-move-far-right
 :n "w c" #'global-command-log-mode
 :n "w SPC" #'clm/toggle-command-log-buffer
 :n "w +" #'evil-window-increase-height
 :n "w -" #'evil-window-decrease-height
 :n "w (" #'evil-window-increase-width
 :n "w )" #'evil-window-decrease-width
 :n "%" #'split-window-below
 :n "|" #'split-window-right

 ;; Modes
 :n "f m l" #'lisp-mode
 :n "f m o" #'org-mode
 :n "f m c" #'clojure-mode
 :n "f m <escape>" #'keyboard-escape-quit

 ;; Flycheck
 :n "e r" #'flycheck-list-errors

 ;; Org Roam
 :n "f a f" #'org-roam-node-find
 :n "f a a" #'org-roam-buffer-toggle
 :n "f a n" #'org-roam-node-insert

 ;; Folding
 :n "f g" #'yafolding-hide-parent-element
 :n "f H" #'yafolding-toggle-all
 :n "f h" #'yafolding-toggle-element

 ;; GPTel (ChatGPT)
 :n "f c" #'gptel         ; Start ChatGPT chat
 :n "f C" #'gptel-menu    ; GPTel menu
 :v "f c" #'gptel-send)   ; Send selected text to ChatGPT

;; Neotree
(setq neo-smart-open t)
(map! :after neotree
      :map neotree-mode-map
      :n "I"  #'neotree-hidden-file-toggle
      :n "i"  #'neotree-hidden-file-toggle
      :n "L"  #'neotree-enter
      :n "R"  #'neotree-refresh
      :n "ma" #'neotree-create-node
      :n "mx" #'neotree-rename-node
      :n "mc" #'neotree-copy-node
      :n "md" #'neotree-delete-node)

;; Lisp
(map! :map emacs-lisp-mode-map
      :n "e b" #'eval-buffer)

;; Clojure Cider
(map! :after clojure-mode
      :map clojure-mode-map
      :n "e c" #'cider-connect
      :n "e b" #'cider-eval-buffer
      :n "e e" #'cider-eval-list-at-point
      :n "e w" #'cider-repl-clear-buffer
      :n "e j" #'cider-find-var
      :n "e k" #'cider-pop-back
      :n "e t" #'cider-test-run-test
      :n "e q" #'cider-quit
      :n "e d" #'cider-debug-defun-at-point
      :n "e <escape>" #'keyboard-escape-quit)

;; Org Custom Evil
(defun my-org-global-show-all ()
  "Show all headings in all Org mode buffers."
  (interactive)
  (org-fold-show-all))

(map! :after evil-org
      :map evil-org-mode-map
      :n "S-<tab>" #'my-org-global-show-all
      :n "<backtab>" #'my-org-global-show-all
      :n "f d" #'org-time-stamp
      :n "f e" #'org-table-export
      :n "L"   #'org-cycle
      :n "R"   #'org-export-dispatch
      :n ">"   #'org-table-wrap-region
      :n "+"   #'org-toggle-checkbox
      :n "#"   #'org-insert-structure-template
      :n "-"   #'org-ctrl-c-minus)

;; Python Custom (jedi/elpy replaced by lsp + Doom lookup/format)
(map! :after python
      :map (python-mode-map python-ts-mode-map)
      :n "e f" #'lsp-goto-type-definition
      :n "e j" #'+lookup/definition
      :n "e e" #'+format/buffer
      :n "e d" #'+lookup/documentation)

;; Claude Set a big buffer so we can search our history.
(with-eval-after-load 'eat
  (setq eat-term-scrollback-size 400000))

;; custom patch: visual selection doesn't overwrite the clipboard
(fset 'evil-visual-update-x-selection 'ignore)

;;; keybindings.el ends here
