;;; dashboard.el --- Ported from dedenbangkit/.doom.d -*- lexical-binding: t; -*-
;;; Commentary:
;; Doom's own dashboard with the old splash and the Akvo menu.
;; Doom renamed `+doom-dashboard-*' to `+dashboard-*'; helm is replaced by
;; plain `find-file' (vertico) in the repo shortcuts.
;;; Code:

;; Splash Screen
(setq fancy-splash-image (concat doom-user-dir "splash.png"))

;; Custom Repos
(defvar my-ideas-dir "~/Repos/akvorepos/ideas/")
(defvar akvo-dir "~/Repos/akvorepos/")
(defvar personal-dir "~/Repos/personal/")
(defvar org-db-file "~/Orgs/database.org")

(defun open-my-ideas ()
  "Write New Org Ideas."
  (interactive)
  (let ((default-directory (expand-file-name my-ideas-dir)))
    (call-interactively #'find-file)))

(defun open-akvo-dir ()
  "List files in Akvo Repository."
  (interactive)
  (let ((default-directory (expand-file-name akvo-dir)))
    (call-interactively #'find-file)))

(defun open-personal-dir ()
  "List files in Personal Repository."
  (interactive)
  (let ((default-directory (expand-file-name personal-dir)))
    (call-interactively #'find-file)))

(defun db-tryout ()
  "Database Tryout."
  (interactive)
  (find-file org-db-file))

(map! :leader
      :desc "List of ideas"                 "f b" #'open-my-ideas
      :desc "List of Repositories"          "f a" #'open-akvo-dir
      :desc "List of Personal Repositories" "f z" #'open-personal-dir
      :desc "Database tryout"               "d d" #'db-tryout)

;; Org Roam
(after! org-roam
  (setq org-roam-directory (expand-file-name "~/Notes")
        org-roam-db-location (expand-file-name "org-roam.db" org-roam-directory)))

;; Dashboard
(setq projectile-enable-caching nil)

;; Delete the dashboard menu
(setq +dashboard-menu-sections (assoc-delete-all "Reload last session" +dashboard-menu-sections))
(setq +dashboard-menu-sections (assoc-delete-all "Open org-agenda" +dashboard-menu-sections))
(setq +dashboard-menu-sections (assoc-delete-all "Recently opened files" +dashboard-menu-sections))
(setq +dashboard-menu-sections (assoc-delete-all "Open documentation" +dashboard-menu-sections))
(setq +dashboard-menu-sections (assoc-delete-all "Jump to bookmark" +dashboard-menu-sections))

;; Replace icons
(plist-put (alist-get "Open project" +dashboard-menu-sections nil nil 'equal)
           :icon '(nerd-icons-octicon "nf-oct-file_directory" :face '+dashboard-menu-title))
(plist-put (alist-get "Open private configuration" +dashboard-menu-sections nil nil 'equal)
           :icon '(nerd-icons-octicon "nf-oct-key" :face '+dashboard-menu-title))

;; Add New Menu (add-to-list prepends, so the last one added is on top)
(add-to-list '+dashboard-menu-sections
             '("Akvo Repositories"
               :icon (nerd-icons-octicon "nf-oct-mark_github" :face '+dashboard-menu-title)
               :when (file-directory-p akvo-dir)
               :action open-akvo-dir))
(add-to-list '+dashboard-menu-sections
             '("Personal Repositories"
               :icon (nerd-icons-octicon "nf-oct-feed_merged" :face '+dashboard-menu-title)
               :when (file-directory-p personal-dir)
               :action open-personal-dir))
(add-to-list '+dashboard-menu-sections
             '("Query Database"
               :icon (nerd-icons-octicon "nf-oct-database" :face '+dashboard-menu-title)
               :action db-tryout))
(add-to-list '+dashboard-menu-sections
             '("Org Room"
               :icon (nerd-icons-octicon "nf-oct-flame" :face '+dashboard-menu-title)
               :action org-roam-node-find))

;;; dashboard.el ends here
