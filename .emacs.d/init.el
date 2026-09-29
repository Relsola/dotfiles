;; -*- lexical-binding: t; -*-

(require 'package)

;; 仓库源
(setq package-archives
      '(("gnu"   . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")))

;; 仓库优先级：同名包优先用 MELPA 的（版本通常最新）
(setq package-archive-priorities
      '(("melpa"  . 10)
        ("gnu"    . 0)))

;; 激活本地已安装的包
(package-initialize) 

;; 先把本地已有的包索引读进来，设置 package-archive-contents
(package-read-all-archive-contents)

;; 本地确实没有索引时，才联网刷新
(unless package-archive-contents
  (package-refresh-contents))

;; Emacs 29+ 内置 use-package，显式 require 一下
(require 'use-package)

;; 让 use-package 自动安装缺失的包
(setq use-package-always-ensure t)

;; 把备份文件集中存放到 .emacs.d/backups 目录
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups" user-emacs-directory))))

;; Custom 生成到单独文件
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; 包加载路径
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; 依次加载各模块
(require 'ui)
(require 'editing)
(require 'completion)
(require 'evil-config)
(require 'term)

;; 主语言配置
(require 'prog/lisp) 
(require 'prog/c-cpp)
