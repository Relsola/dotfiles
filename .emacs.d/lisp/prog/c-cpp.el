;;; c-cpp.el --- C/C++ 开发配置 -*- lexical-binding: t; -*-

(add-to-list 'major-mode-remap-alist '(c-mode        . c-ts-mode))
(add-to-list 'major-mode-remap-alist '(c++-mode      . c++-ts-mode))
(add-to-list 'major-mode-remap-alist '(c-or-c++-mode . c-or-c++-ts-mode))

;; 将 .cc 文件关联到 c++-ts-mode
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-ts-mode))

(use-package eglot
  :ensure nil
  :hook ((c-mode           . eglot-ensure)
         (c++-mode         . eglot-ensure)
         (c-or-c++-mode    . eglot-ensure)
         (c-ts-mode        . eglot-ensure)
         (c++-ts-mode      . eglot-ensure)
         (c-or-c++-ts-mode . eglot-ensure))
  :custom
  (eglot-autoshutdown t)
  :config
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode c-or-c++-mode c-ts-mode c++-ts-mode c-or-c++-ts-mode)
                 . ("clangd"
                    "--header-insertion=never"
                    "--completion-style=detailed"
                    "--background-index"
                    "--clang-tidy"))))

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c C-f") #'eglot-format)
  (define-key eglot-mode-map (kbd "<f2>")  #'eglot-rename))

(provide 'prog/c-cpp) 
