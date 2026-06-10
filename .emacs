(setq custom-file "~/.emacs.custom.el")
(package-initialize)

(add-to-list 'load-path "~/.emacs.local/")

(load "~/.emacs.rc/rc.el")

(load "~/.emacs.rc/misc-rc.el")

;;; Appearance
(defun rc/get-default-font ()
  (cond
   ;; ((eq system-type 'windows-nt) "Consolas-13")
   ;; ((eq system-type 'gnu/linux) "Iosevka-20")))
   ((eq system-type 'windows-nt) "JetBrains Mono")
   ((eq system-type 'gnu/linux) "JetBrains Mono")))


(add-to-list 'default-frame-alist `(font . ,(rc/get-default-font)))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(editorconfig-mode 1)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(rc/require-theme 'atom-one-dark)

; Stop Emacs from losing undo information by
; setting very high limits for undo buffers
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

(server-start)
(delete-selection-mode t)
(global-auto-revert-mode t)
(global-hl-line-mode 1)
(set-face-background 'hl-line "midnight blue")

(setq compilation-directory-locked nil)
(setq shift-select-mode nil)
(setq enable-local-variables nil)

;;; ido
(rc/require 'smex 'ido-completing-read+)
(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-display-line-numbers-mode)

;;; Company
(use-package company
    :ensure t
    :demand t
    :config
    (global-company-mode)
    (setq company-global-modes '(not tuareg-mode-hook))
    (setq company-tooltip-align-annotations t)
    (setq company-idle-delay 0.0)
    (setq company-show-quick-access t)
    (setq company-selection-wrap-around t)
    (setq company-transformers '(company-sort-by-occurrence)))

(use-package company-box
   :ensure t
   :if window-system
   :hook (company-mode . company-box-mode))

;;; magit
(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

;;; multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; Move Text
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; dired
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

;;; rg
(rc/require 'rg 'wgrep)
(require 'rg)
(rg-enable-default-bindings)

;;; powershell
(rc/require 'powershell)
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode))
(add-to-list 'auto-mode-alist '("\\.psm1\\'" . powershell-mode))

;;; word-wrap
(defun rc/enable-word-wrap ()
  (interactive)
  (toggle-word-wrap 1))

(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;;; tramp
;;; http://stackoverflow.com/questions/13794433/how-to-disable-autosave-for-tramp-buffers-in-emacs
(setq tramp-auto-save-directory "/tmp")

(require 'init-dev)
(require 'init-opt)

(require 'cc-dev)

(use-package hl-todo
    :ensure t
    :demand t
    :bind
    ("C-c p" . hl-todo-previous)
    ("C-c n" . hl-todo-next)
    ("C-c o" . hl-todo-occur)
    ("C-c i" . hl-todo-insert)
    :config
    (global-hl-todo-mode)
    (setq hl-todo-keyword-faces
        '(("TODO"   . "#FF0000")
          ("NOTE"   . "#00FF00")
          ("DEBUG"  . "#A020F0")
          ("FIXME"  . "#FF0000")
          ("GOTCHA" . "#FF4500")
          ("STUB"   . "#1E90FF"))))

;;; moving to the beginning/end of code
(use-package mwim
    :ensure t
    :bind
    ("C-a" . mwim-beginning)
    ("C-e" . mwim-end)
    ("<home>" . mwim-beginning-of-line-or-code)
    ("<end>" . mwim-end-of-line-or-code))

;;; ripgrep
(rc/require 'rg)

(global-set-key (kbd "C-c s r") 'rg)
(global-set-key (kbd "C-c s t") 'rg-literal)

;;; Spell Checker
(use-package jinx
    :ensure t
    :hook (emacs-startup . global-jinx-mode)
    :bind
    ("M-$" . jinx-correct)
    ("C-M-$" . jinx-languages)
    :config (setq jinx-languages "en_US"))

;;; LSP
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `((simpc-mode c-mode c++-mode) . ("clangd")))
    (define-key eglot-mode-map (kbd "C-c f") #'eglot-format)
    (define-key eglot-mode-map (kbd "C-c r") #'eglot-rename))

;; (dolist (hook '(simpc-mode-hook c-mode-hook c++-mode))
;;     (add-hook hook #'eglot-ensure))

(load-file custom-file)
