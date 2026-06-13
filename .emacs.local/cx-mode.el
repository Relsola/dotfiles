(require 'subr-x)

(use-package eglot-inactive-regions
    :ensure t
    :custom
    (eglot-inactive-regions-style 'darken-foreground)
    (eglot-inactive-regions-opacity 0.4)
    :config
    (eglot-inactive-regions-mode 1))

(setq major-mode-remap-alist '((c-mode . c-ts-mode) (c++-mode . c++-ts-mode)))
(setq treesit-font-lock-level 4)

(defun cc-smart-arrow-filter ()
    (when (and (eq last-command-event ?-)
              (>= (point) 2)
              (string= (buffer-substring (- (point) 2) (point)) "--"))
        (delete-char -2)
        (insert "->")
        (cond
            ((bound-and-true-p company-mode) (company-manual-begin))
            ((bound-and-true-p corfu-mode) (completion-at-point))
            (t (completion-at-point)))))

(defun cc-setup-smart-arrow-hook ()
  (add-hook 'post-self-insert-hook #'cc-smart-arrow-filter nil t))

(dolist (hook '(c-ts-mode-hook c++-ts-mode-hook))
  (add-hook hook #'eglot-ensure)
  (add-hook hook #'cc-setup-smart-arrow-hook))

(with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
        `((c-mode c++-mode c-ts-mode c++-ts-mode) . ("clangd"
                                                        "--header-insertion=never"
                                                        "--completion-style=detailed"
                                                        "--background-index"
                                                        "--clang-tidy")))
    (define-key eglot-mode-map (kbd "C-c f")  #'eglot-format)
    (define-key eglot-mode-map (kbd "<f2>")   #'eglot-rename))

(provide 'cx-mode)
