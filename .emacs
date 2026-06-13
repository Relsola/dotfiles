(setq custom-file "~/.emacs.custom.el")
(package-initialize)

(add-to-list 'load-path "~/.emacs.local/")

(load "~/.emacs.rc/rc.el")

(load "~/.emacs.rc/misc-rc.el")
(load "~/.emacs.rc/org-mode-rc.el")
(load "~/.emacs.rc/autocommit-rc.el")

;;; Appearance
(defun rc/get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "JetBrains Mono")
   ((eq system-type 'gnu/linux) "JetBrains Mono")))

(add-to-list 'default-frame-alist `(font . ,(rc/get-default-font)))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(editorconfig-mode 1)

(rc/require-theme 'gruber-darker)

(eval-after-load 'zenburn
    (set-face-attribute 'line-number nil :inherit 'default))

; Stop Emacs from losing undo information by
; setting very high limits for undo buffers
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

(delete-selection-mode t)
(global-auto-revert-mode t)
(global-hl-line-mode 1)
(set-face-background 'hl-line "midnight blue")

;;; ido
(rc/require 'smex 'ido-completing-read+)

(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; c-mode
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

;;; Paredit
(rc/require 'paredit)

(defun rc/turn-on-paredit ()
  (interactive)
  (paredit-mode 1))

(add-hook 'emacs-lisp-mode-hook  'rc/turn-on-paredit)
(add-hook 'clojure-mode-hook     'rc/turn-on-paredit)
(add-hook 'lisp-mode-hook        'rc/turn-on-paredit)
(add-hook 'common-lisp-mode-hook 'rc/turn-on-paredit)
(add-hook 'scheme-mode-hook      'rc/turn-on-paredit)
(add-hook 'racket-mode-hook      'rc/turn-on-paredit)

;;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-j")
                            (quote eval-print-last-sexp))))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

;;; uxntal-mode

;;; Haskell mode
(rc/require 'haskell-mode)

(setq haskell-process-type 'cabal-new-repl)
(setq haskell-process-log t)

(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)

(rc/require 'uxntal-mode)

(require 'basm-mode)

(require 'fasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode))

(require 'porth-mode)

(require 'noq-mode)

(require 'jai-mode)

(require 'simpc-mode)

(require 'umka-mode)

(require 'c3-mode)

;;; display-line-numbers-mode
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;;; magit
;; magit requres this lib, but it is not installed automatically on
;; Windows.
(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

;;; multiple cursors
(use-package multiple-cursors
    :ensure t
    :bind
    ("C-S-c C-S-c" . mc/edit-lines)
    ("C->"         . mc/mark-next-like-this)
    ("C-<"         . mc/mark-previous-like-this)
    ("C-c C-<"     . mc/mark-all-like-this)
    ("C-\""        . mc/skip-to-next-like-this)
    ("C-:"         . mc/skip-to-previous-like-this))

;;; dired
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

;;; helm
(rc/require 'helm 'helm-ls-git)

(setq helm-ff-transformer-show-only-basename nil)

(global-set-key (kbd "C-c h t") 'helm-cmd-t)
(global-set-key (kbd "C-c h g l") 'helm-ls-git-ls)
(global-set-key (kbd "C-c h f") 'helm-find)
(global-set-key (kbd "C-c h a") 'helm-org-agenda-files-headings)
(global-set-key (kbd "C-c h r") 'helm-recentf)

;;; word-wrap
(defun rc/enable-word-wrap ()
  (interactive)
  (toggle-word-wrap 1))

(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;;; nxml
(add-to-list 'auto-mode-alist '("\\.html\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.ant\\'" . nxml-mode))

;;; tramp
;;; http://stackoverflow.com/questions/13794433/how-to-disable-autosave-for-tramp-buffers-in-emacs
(setq tramp-auto-save-directory "/tmp")

;;; eldoc mode
(defun rc/turn-on-eldoc-mode ()
  (interactive)
  (eldoc-mode 1))

(add-hook 'emacs-lisp-mode-hook 'rc/turn-on-eldoc-mode)

;;; Company and yasnippet
(use-package company
    :ensure t
    :config
    (global-company-mode)
    (setq company-backends '((company-capf :with company-yasnippet) company-dabbrev-code))
    (setq company-global-modes '(not tuareg-mode-hook))
    (setq company-tooltip-align-annotations t)
    (setq company-minimum-prefix-length 1)
    (setq company-idle-delay 0.0)
    (setq company-show-quick-access t)
    (setq company-selection-wrap-around t)
    (setq company-transformers '(company-sort-by-occurrence)))

(use-package company-box
   :ensure t
   :if window-system
   :hook (company-mode . company-box-mode))

(use-package yasnippet
    :ensure t
    :hook
    (prog-mode . yas-minor-mode)
    :config
    (yas-reload-all)
    (setq yas-triggers-in-field nil)
    (setq yas-snippet-dirs '("~/.emacs.snippets/")))

;;; Typescript
(rc/require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.mts\\'" . typescript-mode))

;;; Tide
(rc/require 'tide)

(defun rc/turn-on-tide-and-flycheck ()  ;Flycheck is a dependency of tide
  (interactive)
  (tide-setup)
  (flycheck-mode 1))

(add-hook 'typescript-mode-hook 'rc/turn-on-tide-and-flycheck)

;;; Proof general
(rc/require 'proof-general)
(add-hook 'coq-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-q C-n")
                            (quote proof-assert-until-point-interactive))))

;;; LaTeX mode
(add-hook 'tex-mode-hook
          (lambda ()
            (interactive)
            (add-to-list 'tex-verbatim-environments "code")))

(setq font-latex-fontify-sectioning 'color)

;;; Move Text
(use-package move-text
    :ensure t
    :bind
    ("M-p" . move-text-up)
    ("M-n" . move-text-down))

;;; Ebisp
(add-to-list 'auto-mode-alist '("\\.ebi\\'" . lisp-mode))

;;; Packages that don't require configuration
(rc/require
 'scala-mode
 'd-mode
 'yaml-mode
 'glsl-mode
 'tuareg
 'lua-mode
 'less-css-mode
 'graphviz-dot-mode
 'clojure-mode
 'cmake-mode
 'rust-mode
 'csharp-mode
 'nim-mode
 'jinja2-mode
 'markdown-mode
 'purescript-mode
 'nix-mode
 'dockerfile-mode
 'toml-mode
 'nginx-mode
 'kotlin-mode
 'go-mode
 'php-mode
 'racket-mode
 'qml-mode
 'ag
 'elpy
 'typescript-mode
 'rfc-mode
 'sml-mode
 )

(load "~/.emacs.shadow/shadow-rc.el" t)

(defun astyle-buffer (&optional justify)
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr"
     nil
     t)
    (goto-line saved-line-number)))

(add-hook 'simpc-mode-hook
          (lambda ()
            (interactive)
            (setq-local fill-paragraph-function 'astyle-buffer)))

(require 'compile)

;; pascalik.pas(24,44) Error: Can't evaluate constant expression

compilation-error-regexp-alist-alist

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))

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
    ("C-a"     . mwim-beginning)
    ("C-e"     . mwim-end)
    ("<home>"  . mwim-beginning-of-line-or-code)
    ("<end>"   . mwim-end-of-line-or-code))

;;; ripgrep
(use-package rg
    :ensure t
    :bind
    ("C-c s r" . rg)
    ("C-c s t" . rg-literal))

;;; Spell Checker
(use-package jinx
    :ensure t
    :hook (emacs-startup . global-jinx-mode)
    :bind
    ("M-$" . jinx-correct)
    ("C-M-$" . jinx-languages)
    :config (setq jinx-languages "en_US"))


;;; Custom C
(require 'cx-mode)

(add-hook 'window-setup-hook (lambda () (global-text-scale-adjust 15)))

(load-file custom-file)
