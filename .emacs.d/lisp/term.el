;;; term.el --- 终端配置 -*- lexical-binding: t; -*-

;; Ghostel: 基于 libghostty 的高性能终端模拟器
(use-package ghostel
  :bind (("C-x m" . ghostel)) ; 绑定快捷键，方便打开终端
  :custom
  ;; 可选：设置滚动缓冲区大小（单位：行）
  (ghostel-scrollback-lines 10000))

(provide 'term)
