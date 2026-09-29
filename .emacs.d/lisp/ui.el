;;; ui.el --- 外观设置 -*- lexical-binding: t; -*-

(setq-default cursor-in-non-selected-windows nil)  ; 非活动窗口不画光标
(setq highlight-nonselected-windows nil)           ; 不高亮非活动窗口

(setq jit-lock-defer-time 0.1)                     ; 延迟 0.1 秒再高亮
(setq redisplay-skip-fontification-on-input t)     ; 输入时暂停语法高亮

(setq-default bidi-display-reordering 'left-to-right   ; 强制所有文本从左到右显示，不按 Unicode 双向算法自动重排
              bidi-paragraph-direction 'left-to-right) ; 段落方向固定为从左到右
(setq bidi-inhibit-bpa t)                              ; 禁用双向文本扫描

(setq-default display-line-numbers-width 4)  ; 行号列宽度固定，防止边距跳跃
(column-number-mode 1)                       ; 模式行显示列号

;; 把 themes 目录加入主题搜索路径
(add-to-list 'custom-theme-load-path
             (expand-file-name "themes" user-emacs-directory))
;; 加载主题
(load-theme 'jblow-nostalgia t)  ; 主题可用放最后加载，确保覆盖前面各包的 face 设置

;; 增强不同 buffer 对比度
(use-package solaire-mode
  :config
  (solaire-global-mode 1)
  (add-to-list 'solaire-mode-remap-alist
               '(ghostel-default . solaire-default-face)))

;; 图标库
(use-package nerd-icons)

;; Mode-line
(use-package doom-modeline
  :custom
  ((doom-modeline-icon 'nerd-icons)
   (doom-modeline-hud t)
   (doom-modeline-project-name nil))
  :hook (after-init . doom-modeline-mode))

;; 特定模式下隐藏 modeline
(use-package mode-line-invisible
  :ensure nil
  :hook ((eshell-mode ghostel-mode shell-mode)))

;; 编程模式启用行号
(use-package display-line-numbers
  :ensure nil
  :hook ((prog-mode
          conf-mode toml-ts-mode
          yaml-mode yaml-ts-mode)
         . display-line-numbers-mode)
  :init (setq display-line-numbers-width-start t))

;; 抑制GUI特性
(setq use-file-dialog nil                               ; 禁用图形文件选择对话框
      use-dialog-box nil                                ; 禁用所有图形对话框
      inhibit-startup-screen t                          ; 不显示启动画面
      inhibit-startup-echo-area-message user-login-name ; 不显示启动消息
      inhibit-default-init t                            ; 不加载默认初始化配置
      initial-scratch-message nil)                      ; *scratch* 缓冲区为空
;; 忽略 daemonp 模式运行
(unless (daemonp)
  (advice-add #'display-startup-echo-area-message :override #'ignore))

;; Display dividers between windows
(setq window-divider-default-places t        ; 窗口的底部和右侧都显示分隔线
      window-divider-default-bottom-width 1  ; 底部和右侧分割线像素为 1px
      window-divider-default-right-width 1)
(add-hook 'window-setup-hook #'window-divider-mode)

;; 滚动基础设置
(setq hscroll-step 1                         ; 水平滚动时每次移动 1 列
      hscroll-margin 2                       ; 光标距离窗口左右边缘 2 列时，才开始水平滚动
      scroll-step 1                          ; 当光标移出可见区域时，窗口只滚动 1 行
      scroll-preserve-screen-position t      ; 翻页时，尽量让光标保持在屏幕上相同的位置
      auto-window-vscroll nil                ; 关闭自动的 像素级垂直滚动
      ;; mouse
      mouse-wheel-scroll-amount-horizontal 1 ; 鼠标横向滚轮每次滚 1 列
      mouse-wheel-progressive-speed nil)     ; 滚动速度恒定

;; 像素级滚动
(use-package ultra-scroll
  :custom
  (scroll-conservatively 3)
  (scroll-margin 0)
  :hook window-setup)

;; 分页符渲染成水平线
(use-package page-break-lines
  :hook (after-init . global-page-break-lines-mode))

(provide 'ui)
