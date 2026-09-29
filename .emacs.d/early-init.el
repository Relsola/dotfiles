;;; early-init.el --- 启动早期配置 -*- lexical-binding: t; -*-

;; 增大进程读取块大小
(setq read-process-output-max #x10000)  ; 64KB

;; 启动时清空，避免每次文件操作都跑正则匹配；启动后再恢复
(let ((default-file-name-handler-alist file-name-handler-alist)
      (default-load-suffixes load-suffixes)
      (default-load-file-rep-suffixes load-file-rep-suffixes))
  (setq file-name-handler-alist nil
        load-suffixes '(".elc" ".el")
        load-file-rep-suffixes '(""))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (setq load-suffixes default-load-suffixes
                    load-file-rep-suffixes default-load-file-rep-suffixes
                    file-name-handler-alist default-file-name-handler-alist))
            101))

;; 路径缓存
(setq load-path-filter-function #'load-path-filter-cache-directory-files)

;; 禁止自动 package 初始化
(setq package-enable-at-startup nil)

;; 指定 utf-8 编码
(prefer-coding-system 'utf-8)

;; 禁止 frame 自动缩放
(setq frame-inhibit-implied-resize t)

;; 关闭UI
(push '(tool-bar-lines . 0) default-frame-alist)   ; 关闭工具栏
(push '(menu-bar-lines . 0) default-frame-alist)   ; 关闭菜单栏
(push '(vertical-scroll-bars) default-frame-alist) ; 关闭滚动条

;; 设置字体 12pt
(set-face-attribute 'default nil
                    :family "JetBrainsMono NF"
                    :height 120)

;; 隐藏 mode-line（防闪白）
(setq-default mode-line-format nil)
