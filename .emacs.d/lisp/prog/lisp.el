;;; lisp.el --- lisp 开发配置 -*- lexical-binding: t; -*-

;; 结构化编辑 Lisp，保证括号永远平衡
;;
;;   M-(         插入一对括号并把光标放中间
;;   C-k / C-w   删除时自动带上配对的括号
;;   C-右 / C-左  按整个表达式前进/后退
;;   M-上 / M-下  把当前表达式和上/下一个交换位置
(use-package paredit
  :hook ((emacs-lisp-mode  . paredit-mode)
         (lisp-mode        . paredit-mode)))

;; 按嵌套深度给括号上色
(use-package rainbow-delimiters
  :hook (emacs-lisp-mode . rainbow-delimiters-mode))

(provide 'prog/lisp)
