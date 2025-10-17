(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages '(vi-tilde-fringe jinja2-mode org-roam))
 '(safe-local-variable-values
   '((eval customize-set-variable 'cider-path-translations
      (let
          ((m2
            (concat
             (getenv "HOME")
             "/.m2")))
        (list
         (cons "/app"
               (clojure-project-dir))
         (cons "/home/akvo/.m2" m2)
         (cons "/root/.m2" m2))))
     (cider-log-framework-name . "Timbre")
     (cider-ns-refresh-after-fn . "integrant.repl/resume")
     (cider-ns-refresh-before-fn . "integrant.repl/suspend")))
 '(warning-suppress-types
   '(((copilot copilot-no-mode-indent))
     (defvaralias)
     (lexical-binding))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(link ((t (:underline nil :weight bold :foreground "#ADD8E6"))))
 '(org-code ((t (:foreground "red"))))
 '(org-level-1 ((t (:inherit outline-1 :weight bold :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :weight bold :height 1.2))))
 '(org-level-3 ((t (:inherit outline-3 :weight bold :height 1.0))))
 '(org-link ((t (:underline nil :weight bold :foreground "blue")))))
