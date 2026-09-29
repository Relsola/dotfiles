;;; editing.el --- 编辑行为 -*- lexical-binding: t; -*-

;; 快捷键提示
(which-key-mode 1)

;; 高亮匹配的括号
(show-paren-mode 1)

;; 将 Shift+方向键在窗口之间按方向切换
(windmove-default-keybindings)
;; 到达边缘时循环到另一侧
(setq windmove-wrap-around t)

;; 选中文本后直接输入会替换掉选区
(delete-selection-mode t)
;; 文件被外部修改时自动刷新 buffer
(global-auto-revert-mode t)
;; 高亮当前行
(global-hl-line-mode -1)
;; 高亮行颜色
(set-face-background 'hl-line "midnight blue")

;; EditorConfig 支持
(editorconfig-mode 1)

;; avy：全屏范围的快速跳转
;;
;;   M-g c  输入字符，跳到它出现的位置
;;   M-g w  输入单词首字母，跳到那个单词
;;   M-g l  屏幕每行标一个字母，按字母跳到那一行
;;   M-g b  跳回上一个位置
;;   M-g g  Emacs 内置跳转行号
(use-package avy
  :bind (("M-g c" . avy-goto-char)
         ("M-g w" . avy-goto-word-1)
         ("M-g l" . avy-goto-line)
         ("M-g b" . avy-pop-mark)))

(provide 'editing)
