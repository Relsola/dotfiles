;;; evil.el --- Vim 键位模拟 -*- lexical-binding: t; -*-

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "C-z") #'evil-emacs-state))

(use-package evil-mc
  :after evil
  :config
  (global-evil-mc-mode 1)) ; 全局启用

(provide 'evil-config)
