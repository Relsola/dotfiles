(setq custom-file "~/.emacs.custom.el")
(package-initialize)

(load "~/.emacs.rc/rc.el")

(rc/require-theme 'atom-one-dark)

;;; ido
(rc/require 'smex 'ido-completing-read+)

(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; clangd LSP
(rc/require 'eglot 'corfu 'cape)

(setq corfu-auto t)
(setq corfu-auto-delay 0.05)
(setq corfu-cycle t)
(setq corfu-preselect 'prompt)
(setq corfu-quit-no-match 'separator)

(global-corfu-mode 1)

(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode)
                 . ("clangd"
                    "--header-insertion=never"))))

(load-file custom-file)
